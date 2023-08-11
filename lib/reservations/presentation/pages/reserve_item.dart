import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticket_booking_app/core/utils/app_constants.dart';
import 'package:ticket_booking_app/reservations/data/models/reservation_model.dart';

import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class ReserveItem extends StatefulWidget {
  final ReservationModel reserve;
  final VoidCallback onTapPay;

  const ReserveItem({
    Key? key,
    required this.reserve,
    required this.onTapPay,
  }) : super(key: key);

  @override
  State<ReserveItem> createState() => _ReserveItemState();
}

class _ReserveItemState extends State<ReserveItem> {
  bool isPaid = false;
  int count = 0;
  String status = 'Unknown';

  @override
  void initState() {
    count = widget.reserve.numberOfTickets ?? 0;
    status = widget.reserve.status ?? 'Unknown';
    if (status == 'Pending') {
      isPaid = false;
    }
    if (status == 'Confirmed') {
      isPaid = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cGrayColor,
      width: double.infinity,
      height: 120.h,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(30.r),
                      topRight: Radius.circular(30.r)),
                  color: isPaid ? cGreenColor : cBrownDark),
              child: Center(
                child: RotatedBox(
                    quarterTurns: -1,
                    child: new Text(
                      isPaid ? "Confirmed" : "Pending",
                      style: TextStyle(color: cWhiteColor),
                    )),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Center(
                    child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        count.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: cFirstColor,
                            fontSize: 50.sp,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      count > 1 ? 'Tickets' : 'Ticket',
                      style: TextStyle(color: cFirstColor, fontSize: 20.sp),
                    )
                  ],
                ))),
          ),
          Expanded(
            flex: 3,
            child: InkWell(
              onTap: widget.onTapPay,
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30.r),
                        topLeft: Radius.circular(30.r)),
                    color: cTextColor),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        Icons.monetization_on_rounded,
                        color: cFirstColor,
                        size: 50,
                      ),
                      SizedBox(width: 10.w),
                      RotatedBox(
                          quarterTurns: -1,

                          child: new Text(
                            'PAY',
                            style: TextStyle(
                                color: cWhiteColor,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w900),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
