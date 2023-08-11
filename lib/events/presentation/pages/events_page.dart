import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_booking_app/auth/login/presentation/pages/login_page.dart';
import 'package:ticket_booking_app/core/di/dependency_injection.dart';
import 'package:ticket_booking_app/core/utils/app_constants.dart';
import 'package:ticket_booking_app/core/utils/string_enums.dart';
import 'package:ticket_booking_app/core/widgets/alert_dialog.dart';
import 'package:ticket_booking_app/core/widgets/custom_toast.dart';
import 'package:ticket_booking_app/events/presentation/bloc/events_bloc.dart';
import 'package:ticket_booking_app/events/presentation/pages/event_form.dart';
import 'package:ticket_booking_app/events/presentation/pages/event_item.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import 'event_detailed.dart';

class EventsPage extends StatefulWidget {
  static Widget screen() {
    return BlocProvider(
      create: (context) => di<EventsBloc>(),
      child: EventsPage(),
    );
  }

  const EventsPage({Key? key}) : super(key: key);

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  final DateFormat formatterHour = DateFormat('yyyy-MM-dd HH:mm');
  final DateFormat formatterDate = DateFormat('yyyy-MM-dd');
  TextEditingController searchController = TextEditingController();

  late bool focused = true;
  late EventsBloc _eventsBloc;
  bool refresh = false;
  String? searchText;

  SharedPreferences prefs = di();

  @override
  void initState() {
    var date = prefs.getString(eventsTime);
    refresh = date != null ? false : true;
    _eventsBloc = BlocProvider.of<EventsBloc>(context);
    _handleRefresh(refresh: true);
    super.initState();
  }

  Future _handleRefresh({
    required bool refresh,
    String? text,
  }) async {
    this.refresh = refresh;
    this.searchText = text;

    _eventsBloc.add(GetEventsEvent(text: text, fromLocal: !refresh));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cFirstColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: BlocConsumer<EventsBloc, EventsState>(
            listener: (ctx, state) {},
            buildWhen: (previous, state) {
              OverlayState? overlay = Overlay.of(context);

              if (state is GetEventsSuccess) {
                return true;
              } else if (state is EventsSuccessState) {
                _handleRefresh(refresh: true);
                return true;
              } else if (state is EventsFailureState) {
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
                return false;
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
              if (state is EventsInitial) {
                return Stack(
                  children: [
                    Container(
                      height: 160.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          gradient: cSecondGradient,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(30.r),
                              bottomLeft: Radius.circular(30.r))),
                      child: Container(),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 60.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.r),
                                      color: cWhiteColor.withAlpha(80)),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 20.w,
                                      ),
                                      Icon(
                                        Icons.search,
                                        color: cWhiteColor,
                                      ),
                                      SizedBox(
                                        width: 20.w,
                                      ),
                                      Expanded(
                                        child: TextField(
                                          decoration: InputDecoration(
                                              hintText: 'Search',
                                              hintStyle:
                                                  TextStyle(color: cWhiteColor),
                                              border: InputBorder.none),
                                          style: TextStyle(color: cWhiteColor),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20.h, vertical: 5.w),
                          padding: EdgeInsets.symmetric(vertical: 5.h),
                          child: Text(
                              'Last update: ' +
                                  "${prefs.getString(eventsTime) ?? "00-00-0000 00.00.00"}",
                              style: TextStyle(color: cWhiteColor)),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: cFirstColor,
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
                    ),
                  ],
                );
              } else if (state is EventsLoading) {
                return Stack(
                  children: [
                    Container(
                      height: 160.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          gradient: cSecondGradient,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(30.r),
                              bottomLeft: Radius.circular(30.r))),
                      child: Container(),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 60.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.r),
                                      color: cWhiteColor.withAlpha(80)),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 20.w,
                                      ),
                                      Icon(
                                        Icons.search,
                                        color: cWhiteColor,
                                      ),
                                      SizedBox(
                                        width: 20.w,
                                      ),
                                      Expanded(
                                        child: TextField(
                                          decoration: InputDecoration(
                                              hintText: 'Search',
                                              hintStyle:
                                                  TextStyle(color: cWhiteColor),
                                              border: InputBorder.none),
                                          style: TextStyle(color: cWhiteColor),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20.h, vertical: 5.w),
                          padding: EdgeInsets.symmetric(vertical: 5.h),
                          child: Text(
                              'Last update: ' +
                                  "${prefs.getString(eventsTime) ?? "00-00-0000 00.00.00"}",
                              style: TextStyle(color: cWhiteColor)),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: cFirstColor,
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
                    ),
                  ],
                );
              } else if (state is GetEventsSuccess) {
                if (state.resultList.isNotEmpty)
                  return Stack(
                    children: [
                      Container(
                        height: 160.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            gradient: cSecondGradient,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(30.r),
                                bottomLeft: Radius.circular(30.r))),
                        child: Container(),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 60.h,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                        color: cWhiteColor.withAlpha(80)),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 20.w,
                                        ),
                                        Icon(
                                          Icons.search,
                                          color: cWhiteColor,
                                        ),
                                        SizedBox(
                                          width: 20.w,
                                        ),
                                        Expanded(
                                          child: TextField(
                                            controller: searchController,
                                            decoration: InputDecoration(
                                                hintText: 'Search',
                                                hintStyle: TextStyle(
                                                    color: cWhiteColor),
                                                border: InputBorder.none),
                                            style:
                                                TextStyle(color: cWhiteColor),
                                            onChanged: (value) {
                                              setState(() {
                                                _handleRefresh(
                                                    refresh: true, text: value);
                                              });
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20.h, vertical: 5.w),
                            padding: EdgeInsets.symmetric(vertical: 5.h),
                            child: Text(
                                'Last update: ' +
                                    "${prefs.getString(eventsTime) ?? "00-00-0000 00.00.00"}",
                                style: TextStyle(color: cWhiteColor)),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: cFirstColor,
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          Expanded(
                              child: RefreshIndicator(
                                  onRefresh: () async {
                                    _handleRefresh(refresh: true);
                                  },
                                  child: ListView.builder(
                                    itemCount: state.resultList.length,
                                    physics: AlwaysScrollableScrollPhysics(
                                        parent: BouncingScrollPhysics()),
                                    padding: EdgeInsets.only(
                                        bottom: 140.h, top: 20.h),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      var events = state.resultList;
                                      var item = events[index];
                                      return EventItem(
                                        onTapItem: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EventDetailedPage.screen(
                                                        eventModel: item,
                                                      )));
                                        },
                                        event: item,
                                        onTapEdit: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EventFormPage.screen(
                                                          eventModel: item)));
                                        },
                                        onTapDelete: () async {
                                          var result = await showAlertText(
                                                  context, 'Are you sure?') ??
                                              false;
                                          if (result) {
                                            _eventsBloc
                                                .add(DeleteEvent(event: item));
                                          }
                                        },
                                      );
                                    },
                                  )))
                        ],
                      ),
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
}
