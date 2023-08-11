import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_booking_app/auth/login/presentation/pages/login_page.dart';
import 'package:ticket_booking_app/core/di/dependency_injection.dart';
import 'package:ticket_booking_app/core/utils/app_constants.dart';
import 'package:ticket_booking_app/core/utils/string_enums.dart';
import 'package:ticket_booking_app/core/widgets/custom_material_button.dart';
import 'package:ticket_booking_app/core/widgets/custom_toast.dart';
import 'package:ticket_booking_app/events/data/models/event_model.dart';
import 'package:ticket_booking_app/events/presentation/bloc/events_bloc.dart';
import 'package:ticket_booking_app/events/presentation/pages/events_page.dart';
import 'package:ticket_booking_app/events/presentation/widgets/number_stepper.dart';
import 'package:ticket_booking_app/navigation/navigation.dart';
import 'package:ticket_booking_app/reservations/presentation/pages/reserve_page.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class EventDetailedPage extends StatefulWidget {
  final EventModel eventModel;

  static screen({required EventModel eventModel}) {
    return BlocProvider(
      create: (context) => di<EventsBloc>(),
      child: EventDetailedPage(
        eventModel: eventModel,
      ),
    );
  }

  const EventDetailedPage({super.key, required this.eventModel});

  @override
  State<EventDetailedPage> createState() => _EventDetailedPageState();
}

class _EventDetailedPageState extends State<EventDetailedPage> {
  late EventModel event;
  int reserveCount = 0;
  late EventsBloc _eventsBloc;
  SharedPreferences prefs = di();
  late OverlayState overlay;
  final DateFormat formatterDate = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    _eventsBloc = BlocProvider.of<EventsBloc>(context);
    event = widget.eventModel;
    overlay = Overlay.of(context);
    super.initState();
  }

  void showNumberDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0.r),
          ),
          title: Center(child: Text('Reserve')),
          content: NumberStepper(
            initialValue: 0,
            min: 0,
            max: event.numberOfSeats ?? 0,
            step: 1,
            onChanged: (count) {
              reserveCount = count;
            },
          ),
          actionsAlignment: MainAxisAlignment.spaceAround,
          actionsOverflowAlignment: OverflowBarAlignment.center,
          actionsPadding: EdgeInsets.only(bottom: 20.h),
          actions: [
            CustomSolidButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: cWhiteColor),
              ),
              color: cSecondColor,
              hasShadow: true,
              height: 50.h,
              width: 120.w,
            ),
            SizedBox(
              width: 10.w,
            ),
            CustomSolidButton(
              onPressed: () {
                // Perform any actions with the chosen numberValue here
                ///Push replace with Reservation page and refresh(true) after successfully reserving a seat
                _eventsBloc
                    .add(ReserveEvent(id: event.id, count: reserveCount));
              },
              child: Text(
                'OK',
                style: TextStyle(color: cWhiteColor),
              ),
              color: cSecondColor,
              hasShadow: true,
              height: 50.h,
              width: 120.w,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<EventsBloc, EventsState>(
        listener: (BuildContext context, state) {
          if (state is EventsSuccessState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ReservesPage.screen()),
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
            physics: PageScrollPhysics(),
            slivers: [
              SliverAppBar(
                iconTheme: IconThemeData(color: cWhiteColor),
                primary: true,
                pinned: true,
                backgroundColor: cFirstColor,
                expandedHeight: MediaQuery.of(context).size.height * 0.45,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: Container(
                    child: Stack(
                      children: [
                        CachedNetworkImage(
                          color: cFirstColor.withOpacity(0.8),
                          colorBlendMode: BlendMode.darken,
                          height: double.infinity,
                          width: double.infinity,
                          imageUrl: placeholderImage2,
                          fit: BoxFit.cover,
                          errorWidget: (context, error, stacktrace) {
                            return Expanded(
                                child: Container(
                              color: cFirstColor,
                            ));
                          },
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 120.h,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    event.name.toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 25.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      decoration: ShapeDecoration(
                                        shape: StadiumBorder(),
                                        color: Colors.grey[400],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(event.topic.toString()),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Container(
                                      decoration: ShapeDecoration(
                                        shape: StadiumBorder(),
                                        color: Colors.grey[400],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text("etc"),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: MediaQuery.of(context).size.height - 200.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    color: Colors.transparent,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 30.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.w, vertical: 10.h),
                        child: Row(
                          children: [
                            Icon(
                              Ionicons.information_circle,
                              color: cFirstColor,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Flexible(
                              child: Text(
                                '${event.description}',
                                style: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.w, vertical: 10.h),
                        child: Row(
                          children: [
                            Icon(
                              Ionicons.cash,
                              color: cFirstColor,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Flexible(
                              child: Text(
                                'Price: ${event.ticketPrice} ${event.currency}',
                                style: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.w, vertical: 10.h),
                        child: Row(
                          children: [
                            Icon(
                              Ionicons.person,
                              color: cFirstColor,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Flexible(
                              child: Text(
                                'Number of seats: ${event.numberOfSeats}',
                                style: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.w, vertical: 10.h),
                        child: Row(
                          children: [
                            Icon(
                              Ionicons.location,
                              color: cFirstColor,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Flexible(
                              child: Text(
                                'Place: ${event.place}',
                                style: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.w, vertical: 10.h),
                        child: Row(
                          children: [
                            Icon(
                              Ionicons.calendar,
                              color: cFirstColor,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Flexible(
                              child: Text(
                                'Date: ${formatterDate.format(DateTime.parse(event.date??'1970-00-00'))}',
                                style: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.w,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: CustomSolidButton(
                          width: double.infinity,
                          onPressed: () {
                            if (event.numberOfSeats == 0) {
                              CustomToast.showToast('All seats are reserved!');
                            } else {
                              showNumberDialog(context);
                            }
                          },
                          child: Text(
                            'RESERVE',
                            style: TextStyle(color: cWhiteColor),
                          ),
                          color: cTextColor,
                          hasShadow: true,
                          height: 50.h,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
