import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_booking_app/auth/login/presentation/pages/login_page.dart';
import 'package:ticket_booking_app/core/di/dependency_injection.dart';
import 'package:ticket_booking_app/core/utils/app_constants.dart';
import 'package:ticket_booking_app/core/utils/string_enums.dart';
import 'package:ticket_booking_app/core/widgets/custom_material_button.dart';
import 'package:ticket_booking_app/reservations/data/models/reservation_model.dart';
import 'package:ticket_booking_app/reservations/presentation/bloc/reserve_bloc.dart';
import 'package:ticket_booking_app/reservations/presentation/pages/reserve_item.dart';
import 'package:ticket_booking_app/reservations/presentation/widgets/number_stepper.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ReservesPage extends StatefulWidget {
  static Widget screen() {
    return BlocProvider(
      create: (context) => di<ReservesBloc>(),
      child: ReservesPage(),
    );
  }

  const ReservesPage({Key? key}) : super(key: key);

  @override
  State<ReservesPage> createState() => _ReservesPageState();
}

class _ReservesPageState extends State<ReservesPage> {
  final DateFormat formatterHour = DateFormat('yyyy-MM-dd HH:mm');
  final DateFormat formatterDate = DateFormat('yyyy-MM-dd');
  TextEditingController searchController = TextEditingController();

  late bool focused = true;
  late ReservesBloc _reservesBloc;
  bool refresh = false;
  String? searchText;
  int reserveCount = 0;

  SharedPreferences prefs = di();

  @override
  void initState() {
    var date = prefs.getString(reserveTime);
    refresh = date != null ? false : true;
    _reservesBloc = BlocProvider.of<ReservesBloc>(context);
    _handleRefresh(refresh: true);
    super.initState();
  }

  Future _handleRefresh({
    required bool refresh,
  }) async {
    this.refresh = refresh;

    _reservesBloc.add(GetReservesEvent(fromLocal: !refresh));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cFirstColor,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: cWhiteColor),
        backgroundColor: cSecondColor,
        title: Text(
          'Reservations',
          style: TextStyle(color: cWhiteColor),
        ),
      ),
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: BlocConsumer<ReservesBloc, ReservesState>(
            listener: (context, state) {},
            buildWhen: (prevState, state) {
              OverlayState? overlay = Overlay.of(context);

              if (state is GetReservesSuccess) {
                return true;
              } else if (state is ReservesSuccessState) {
                WidgetsBinding.instance.addPostFrameCallback((time) {
                  // Snack(LocaleKeys.noInternetConnection.tr(), context,
                  //     cRedColor);
                  showTopSnackBar(
                    overlay,
                    CustomSnackBar.success(
                      message: state.message,
                    ),
                  );
                });
                _handleRefresh(refresh: true);
                return true;
              } else if (state is ReservesFailureState) {
                WidgetsBinding.instance.addPostFrameCallback((time) {
                  // Snack(LocaleKeys.noInternetConnection.tr(), context,
                  //     cRedColor);
                  showTopSnackBar(
                    overlay,
                    CustomSnackBar.error(
                      message: state.message,
                    ),
                  );
                });
                _handleRefresh(refresh: true);
                return true;
              } else if (state is NoInternetConnection) {
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
                return false;
              } else if (state is AuthFailureState) {
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
              } else
                return false;
              return true;
            },
            builder: (context, state) {
              print(state.runtimeType);
              if (state is ReservesInitial) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20.h, vertical: 5.w),
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      child: Text(
                          'Last update: ' +
                              "${prefs.getString(reserveTime) ?? "00-00-0000 00.00.00"}",
                          style: TextStyle(color: cWhiteColor)),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: cSecondColor,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Expanded(
                        child: Center(
                      child: CupertinoActivityIndicator(
                        color: cWhiteColor,
                        radius: 20.r,
                      ),
                    ))
                  ],
                );
              } else if (state is ReservesLoading) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20.h, vertical: 5.w),
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      child: Text(
                          'Last update: ' +
                              "${prefs.getString(reserveTime) ?? "00-00-0000 00.00.00"}",
                          style: TextStyle(color: cWhiteColor)),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: cSecondColor,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Expanded(
                        child: Center(
                      child: CupertinoActivityIndicator(
                        color: cWhiteColor,
                        radius: 20.r,
                      ),
                    ))
                  ],
                );
              } else if (state is GetReservesSuccess) {
                if (state.resultList.isNotEmpty)
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30.h,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 20.h, vertical: 5.w),
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        child: Text(
                            'Last update: ' +
                                "${prefs.getString(reserveTime) ?? "00-00-0000 00.00.00"}",
                            style: TextStyle(color: cWhiteColor)),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: cSecondColor,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Expanded(
                          child: RefreshIndicator(
                              onRefresh: () async {
                                _handleRefresh(refresh: true);
                              },
                              child: ListView.separated(
                                separatorBuilder: (context, index) {
                                  return Divider();
                                },
                                itemCount: state.resultList.length,
                                physics: AlwaysScrollableScrollPhysics(
                                    parent: BouncingScrollPhysics()),
                                padding: EdgeInsets.only(bottom: 140.h),
                                itemBuilder: (BuildContext context, int index) {
                                  var events = state.resultList;
                                  var item = events[index];
                                  return Slidable(
                                    // The end action pane is the one at the right or the bottom side.
                                    endActionPane: ActionPane(
                                      motion: ScrollMotion(),
                                      children: [
                                        SlidableAction(
                                          // An action can be bigger than the others.
                                          flex: 1,
                                          onPressed: (ctx) {
                                            showNumberDialog(context,
                                                item.event ?? 0, item.id ?? 0);
                                          },
                                          backgroundColor: cGreenColor,
                                          foregroundColor: Colors.white,
                                          icon: Icons.edit,
                                          label: 'Edit',
                                        ),
                                        SlidableAction(
                                          spacing: 1,
                                          flex: 1,
                                          onPressed: (ctx) {
                                            _reservesBloc.add(
                                                DeleteReserveEvent(
                                                    id: item.id));
                                          },
                                          backgroundColor: cBrownDark,
                                          foregroundColor: Colors.white,
                                          icon: Icons.delete_sweep,
                                          label: 'Delete',
                                        ),
                                      ],
                                    ),
                                    child: ReserveItem(
                                      onTapPay: () {
                                        _reservesBloc
                                            .add(PayReserveEvent(id: item.id));
                                      },
                                      reserve: item,
                                    ),
                                  );
                                },
                              )))
                    ],
                  );
                else {
                  return Center(
                    child: ClipRect(
                      child: Container(
                        height: 300.h,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            Expanded(
                                child: Icon(
                              Ionicons.file_tray,
                              size: 140,
                              color: cWhiteColor,
                            )),
                            Padding(
                                padding: EdgeInsets.only(
                                    top: 10.h,
                                    left: 30.w,
                                    right: 30.w,
                                    bottom: 10.h),
                                child: Text(
                                  'Do you want to update?',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: cWhiteColor),
                                )),
                            CupertinoButton(
                                child: Text(
                                  'Refresh',
                                  style: TextStyle(color: cWhiteColor),
                                ),
                                color: cGrayColor1.withAlpha(80),
                                onPressed: () {
                                  _handleRefresh(refresh: true);
                                }),
                            SizedBox(
                              height: 20.h,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  void showNumberDialog(BuildContext context, int eventId, int id) {
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
            max: 50,
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
                _reservesBloc.add(UpdateReserveEvent(
                    id: id, eventId: eventId, count: reserveCount));
                Navigator.pop(context);
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
}
