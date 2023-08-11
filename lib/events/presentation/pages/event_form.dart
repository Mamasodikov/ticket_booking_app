import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_booking_app/auth/login/presentation/pages/login_page.dart';
import 'package:ticket_booking_app/core/di/dependency_injection.dart';
import 'package:ticket_booking_app/core/utils/api_path.dart';
import 'package:ticket_booking_app/core/utils/app_constants.dart';
import 'package:ticket_booking_app/core/utils/string_enums.dart';
import 'package:ticket_booking_app/core/widgets/custom_material_button.dart';
import 'package:ticket_booking_app/core/widgets/custom_toast.dart';
import 'package:ticket_booking_app/core/widgets/text_item.dart';
import 'package:ticket_booking_app/events/data/models/event_create_model.dart';
import 'package:ticket_booking_app/events/data/models/event_model.dart';
import 'package:ticket_booking_app/events/presentation/bloc/events_bloc.dart';
import 'package:ticket_booking_app/events/presentation/pages/events_page.dart';
import 'package:ticket_booking_app/events/presentation/widgets/number_stepper.dart';
import 'package:ticket_booking_app/navigation/navigation.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:http/http.dart' as http;

class EventFormPage extends StatefulWidget {
  final EventModel? eventModel;

  static screen({EventModel? eventModel}) {
    return BlocProvider(
      create: (context) => di<EventsBloc>(),
      child: EventFormPage(
        eventModel: eventModel,
      ),
    );
  }

  const EventFormPage({super.key, this.eventModel});

  @override
  State<EventFormPage> createState() => _EventFormPageState();
}

class _EventFormPageState extends State<EventFormPage> {
  EventModel? event;
  bool isCreate = true;
  late EventsBloc _eventsBloc;
  SharedPreferences prefs = di();
  late OverlayState overlay;
  CurrencyModel selectedCurrency = currencies.first;
  TopicModel selectedTopic = topics.first;
  DateTime selectedDate = DateTime.now();
  File? selectedImage;
  final ImagePicker picker = ImagePicker();
  final DateFormat formatterDate = DateFormat('yyyy-MM-dd');

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController seatsController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    _eventsBloc = BlocProvider.of<EventsBloc>(context);
    event = widget.eventModel;
    isCreate = event == null ? true : false;
    overlay = Overlay.of(context);

    !isCreate
        ? selectedCurrency =
            CurrencyModel(event?.currency ?? 'USD', event?.currency ?? 'USD')
        : selectedCurrency;
    !isCreate
        ? selectedTopic =
            TopicModel(event?.topic ?? 'Biology', event?.topic ?? 'Biology')
        : selectedTopic;
    !isCreate
        ? selectedDate = DateTime.parse(event?.date ?? '2023-00-00')
        : selectedDate;

    if (!isCreate) {
      checkAndSave(placeholderImage2).then((value) => selectedImage = value);
    }

    !isCreate ? nameController.text = event?.name ?? '' : null;
    !isCreate ? priceController.text = event?.ticketPrice ?? '' : null;
    !isCreate
        ? seatsController.text = (event?.numberOfSeats ?? 0).toString()
        : null;
    !isCreate ? placeController.text = event?.place ?? '' : null;
    !isCreate ? descriptionController.text = event?.description ?? '' : null;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<EventsBloc, EventsState>(
        listener: (BuildContext context, state) {
          if (state is EventsSuccessState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => BottomNavigationPage()),
            );
          }
          if (state is NoInternetConnection) {
            WidgetsBinding.instance.addPostFrameCallback((time) {
              // Snack(LocaleKeys.noInternetConnection.tr(), context,
              //     cRedColor);
              showTopSnackBar(
                overlay,
                CustomSnackBar.info(
                  message: noInternetConnection,
                ),
              );
            });
          }
          if (state is EventsFailureState) {
            WidgetsBinding.instance.addPostFrameCallback((time) {
              // SnackToast.showToast(LocaleKeys.serverError.tr(), cRedColor);
              // Snack(LocaleKeys.serverError.tr(), context, cRedColor);
              showTopSnackBar(
                overlay,
                CustomSnackBar.error(
                  message: state.message,
                ),
              );
            });
          }
          if (state is AuthFailureState) {
            WidgetsBinding.instance.addPostFrameCallback((time) {
              // SnackToast.showToast(LocaleKeys.serverError.tr(), cRedColor);
              // Snack(LocaleKeys.serverError.tr(), context, cRedColor);
              showTopSnackBar(
                overlay,
                CustomSnackBar.error(
                  message: state.message,
                ),
              );
              prefs.remove('token');
              prefs.remove('session');
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage.screen()),
              );
            });
          }
        },
        child: Container(
          color: cGrayColor,
          child: CustomScrollView(
            // physics: PageScrollPhysics(),
            slivers: [
              SliverAppBar(
                primary: true,
                pinned: true,
                iconTheme: IconThemeData(color: cWhiteColor),
                backgroundColor: Colors.white,
                expandedHeight: MediaQuery.of(context).size.height * 0.45,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: InkWell(
                    onTap: () async {
                      final XFile? image = await checkAndPick();
                      if (image != null) {
                        setState(() {
                          selectedImage = File(image.path);
                        });
                      }
                    },
                    child: Container(
                      child: Stack(
                        children: [
                          selectedImage == null
                              ? CachedNetworkImage(
                                  color: cFirstColor.withOpacity(0.8),
                                  colorBlendMode: BlendMode.darken,
                                  height: double.infinity,
                                  width: double.infinity,
                                  imageUrl: isCreate
                                      ? placeholderImage1
                                      : placeholderImage2,
                                  fit: BoxFit.cover,
                                  errorWidget: (context, error, stacktrace) {
                                    return Expanded(
                                        child: Container(
                                      color: cFirstColor,
                                    ));
                                  },
                                )
                              : Image.file(
                                  color: cFirstColor.withOpacity(0.8),
                                  colorBlendMode: BlendMode.darken,
                                  selectedImage!,
                                  fit: BoxFit.cover,
                                  height: double.infinity,
                                  width: double.infinity,
                                ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Expanded(
                              child: Container(
                                height: 70.h,
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30.w, vertical: 20.h),
                                decoration: BoxDecoration(
                                  color: cWhiteColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30.r),
                                    topRight: Radius.circular(30.r),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        'Create an event',
                                        style: TextStyle(
                                            fontSize: 25.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Icon(isCreate ? Icons.add : Icons.edit,
                                color: Colors.white, size: 150),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: MediaQuery.of(context).size.height - 180.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    color: Colors.transparent,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 30.h,
                          ),
                          textField(title: 'Name', controller: nameController),
                          InkWell(
                            onTap: () {
                              showMaterialRadioPicker<TopicModel>(
                                backgroundColor: cGrayColor,
                                buttonTextColor: cFirstColor,
                                headerTextColor: cWhiteColor,
                                headerColor: cFirstColor,
                                context: context,
                                title: 'Pick a topic',
                                items: topics,
                                selectedItem: selectedTopic,
                                onChanged: (value) =>
                                    setState(() => selectedTopic = value),
                              );
                            },
                            child: textField(
                                title: selectedTopic.name,
                                isEditable: false,
                                controller: TextEditingController()),
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: textField(
                                    title: 'Price',
                                    keyboardType: TextInputType.number,
                                    controller: priceController),
                              ),
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    showMaterialRadioPicker<CurrencyModel>(
                                      backgroundColor: cGrayColor,
                                      buttonTextColor: cFirstColor,
                                      headerTextColor: cWhiteColor,
                                      headerColor: cFirstColor,
                                      context: context,
                                      title: 'Pick a currency',
                                      items: currencies,
                                      selectedItem: selectedCurrency,
                                      onChanged: (value) => setState(
                                          () => selectedCurrency = value),
                                    );
                                  },
                                  child: textField(
                                      title: selectedCurrency.name,
                                      keyboardType: TextInputType.number,
                                      isEditable: false,
                                      controller: TextEditingController()),
                                ),
                              ),
                            ],
                          ),
                          textField(
                              title: 'Number of seats',
                              keyboardType: TextInputType.number,
                              controller: seatsController),
                          textField(
                              title: 'Place', controller: placeController),
                          textField(
                              title: 'Description',
                              controller: descriptionController),
                          InkWell(
                            onTap: () {
                              showMaterialDatePicker(
                                title: 'Select a date',
                                backgroundColor: cGrayColor,
                                buttonTextColor: cFirstColor,
                                headerTextColor: cWhiteColor,
                                headerColor: cFirstColor,
                                context: context,
                                selectedDate: selectedDate,
                                onChanged: (value) {
                                  ///TODO: add time picker also
                                  setState(() => selectedDate = value);
                                },
                                firstDate: DateTime(1970),
                                lastDate: DateTime(2050),
                              );
                            },
                            child: textField(
                                placeholder: formatterDate.format(selectedDate),
                                title: 'Date & Time',
                                isEditable: false,
                                controller: TextEditingController()),
                          ),
                          SizedBox(
                            height: 20.w,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: CustomSolidButton(
                              width: double.infinity,
                              onPressed: () {
                                EventCreateModel model = EventCreateModel(
                                  id: event?.id,
                                  name: nameController.text,
                                  topic: selectedTopic.name,
                                  date: selectedDate.toString(),
                                  place: placeController.text,
                                  currency: selectedCurrency.code,
                                  numberOfSeats: int.parse(
                                      seatsController.text.isEmpty
                                          ? "0"
                                          : (seatsController.text)),
                                  ticketPrice: priceController.text,
                                  thumbnail: selectedImage,
                                  description: descriptionController.text,
                                );
                                if (isCreate) {
                                  _eventsBloc.add(CreateEvent(event: model));
                                } else {
                                  _eventsBloc.add(UpdateEvent(event: model));
                                }
                              },
                              child: Text(
                                isCreate ? 'Create event' : 'Modify',
                                style: TextStyle(color: cWhiteColor),
                              ),
                              color: cTextColor,
                              hasShadow: true,
                              height: 50.h,
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<File?> imageFileFromUrl(String url) async {
    Dio dio = di();
    var responseData =
        await dio.download(url, '/storage/emulated/0/Download/example.jpg');
    if (responseData.statusCode == 200) {
      File file = await File('/storage/emulated/0/Download/example.jpg');
      return file;
    } else
      return null;
  }

  Future<XFile?> checkAndPick() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS || Platform.isWindows) {
      return picker.pickImage(source: ImageSource.gallery);
    } else if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      var status = await Permission.storage.status;
      if (androidInfo.version.sdkInt <= 29) {
        if (status.isGranted) {
          return picker.pickImage(source: ImageSource.gallery);
        } else if (status.isLimited | status.isRestricted | status.isDenied) {
          await Permission.storage.request();
        } else {
          if (!await Permission.storage.shouldShowRequestRationale) {
            openAppSettings();
          }
        }
      } else {
        return picker.pickImage(source: ImageSource.gallery);
      }
    }
  }

  Future<File?> checkAndSave(String url) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS || Platform.isWindows) {
      return imageFileFromUrl(url);
    } else if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      var status = await Permission.storage.status;
      if (androidInfo.version.sdkInt <= 29) {
        if (status.isGranted) {
          return imageFileFromUrl(url);
        } else if (status.isLimited | status.isRestricted | status.isDenied) {
          await Permission.storage.request();
        } else {
          if (!await Permission.storage.shouldShowRequestRationale) {
            openAppSettings();
          }
        }
      } else {
        return imageFileFromUrl(url);
      }
    }
  }

  getPath() async {
    String? path = "";
    if (Platform.isIOS || Platform.isWindows) {
      final Directory? downloadsDir = await getApplicationDocumentsDirectory();
      return path = downloadsDir?.path;
    } else {
      return path = "/storage/emulated/0/Download";
    }
  }
}
