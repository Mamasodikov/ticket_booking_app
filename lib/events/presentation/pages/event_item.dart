import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ionicons/ionicons.dart';
import 'package:ticket_booking_app/core/utils/app_constants.dart';
import 'package:ticket_booking_app/core/utils/string_enums.dart';
import 'package:ticket_booking_app/core/widgets/custom_material_button.dart';
import 'package:ticket_booking_app/events/data/models/event_model.dart';
import 'package:ticket_booking_app/events/presentation/pages/event_form.dart';
import 'package:ticket_widget/ticket_widget.dart';

import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class EventItem extends StatefulWidget {
  final EventModel event;
  final VoidCallback? onTapItem;
  final VoidCallback? onTapEdit;
  final VoidCallback? onTapDelete;

  const EventItem({
    Key? key,
    required this.event,
    required this.onTapItem,
    required this.onTapEdit,
    required this.onTapDelete,
  }) : super(key: key);

  @override
  State<EventItem> createState() => _EventItemState();
}

class _EventItemState extends State<EventItem> {
  final DateFormat formatterHour = DateFormat('HH:mm');
  final DateFormat formatterDate = DateFormat('yyyy/MM/dd');

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: widget.onTapItem,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        child: TicketWidget(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2,
          isCornerRounded: true,
          child: Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(),
            // padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 5,
                  width: MediaQuery.of(context).size.width,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 6),
                          color: cSecondColor.withAlpha(20),
                          spreadRadius: 4,
                          blurRadius: 4)
                    ],
                    gradient: cThirdGradient,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(60.r),
                      bottomRight: Radius.circular(60.r),
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r),
                    ),
                  ),
                  child: CachedNetworkImage(
                    imageUrl:
                        // event.thumbnail ??
                        placeholderImage2,
                    fit: BoxFit.cover,
                    errorWidget: (context, error, stacktrace) {
                      return Expanded(
                          child: Image.network(
                        "https://via.placeholder.com/500",
                        fit: BoxFit.cover,
                      ));
                    },
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Row(
                    children: [
                      Text(
                        widget.event.name.toString(),
                        style: TextStyle(
                            fontSize: 25.sp, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Row(
                    children: [
                      Icon(
                        Ionicons.megaphone,
                        color: cFirstColor,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Flexible(
                        child: Text(
                          widget.event.topic.toString(),
                          style: TextStyle(
                              fontSize: 17.sp, fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
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
                          'Price: ${widget.event.ticketPrice} ${widget.event.currency}',
                          style: TextStyle(
                              fontSize: 17.sp, fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
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
                          'Number of seats: ${widget.event.numberOfSeats}',
                          style: TextStyle(
                              fontSize: 17.sp, fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
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
                          'Place: ${widget.event.place}',
                          style: TextStyle(
                              fontSize: 17.sp, fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
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
                          'Date: ${widget.event.date}',
                          style: TextStyle(
                              fontSize: 17.sp, fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.w,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: CustomSolidButton(
                          onPressed: widget.onTapDelete,
                          child: Text(
                            'DELETE',
                            style: TextStyle(color: cWhiteColor),
                          ),
                          color: cBrownLight,
                          hasShadow: true,
                          height: 50.h,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: CustomSolidButton(
                          onPressed: widget.onTapEdit,
                          child: Text(
                            'EDIT',
                            style: TextStyle(color: cWhiteColor),
                          ),
                          color: cSecondColor,
                          hasShadow: true,
                          height: 50.h,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
