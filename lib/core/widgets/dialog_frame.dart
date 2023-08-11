import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ticket_booking_app/core/utils/app_constants.dart';

class AllDialogSkeleton extends StatefulWidget {
  final Widget child;
  final String title, icon;
  final Color? color;
  final double? radius;
  final Color? textColor;
  final Color? iconColor;
  final FontWeight? fontWeight;

  const AllDialogSkeleton({
    Key? key,
    required this.child,
    required this.title,
    required this.icon,
    this.color,
    this.radius,
    this.textColor,
    this.iconColor,
    this.fontWeight,
  }) : super(key: key);

  @override
  State<AllDialogSkeleton> createState() => _AllDialogSkeletonState();
}

class _AllDialogSkeletonState extends State<AllDialogSkeleton> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Padding(
        // margin: EdgeInsets.only(
        //     bottom: MediaQuery.of(context).size.height / 5),
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        child: Dialog(
          backgroundColor: widget.color ?? cWhiteColor,
          alignment: Alignment.center,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
          insetPadding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 0),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.radius ?? 20.r)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(widget.icon,
                        color: widget.iconColor ?? cFirstColor,
                        height: 20.h,
                        width: 20.w),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(widget.title,
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: widget.fontWeight ?? FontWeight.w400,
                              fontFamily: 'Medium',
                              color: widget.textColor ?? cBlackColor)),
                    ),
                    InkWell(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                      borderRadius: BorderRadius.circular(22.r),
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.cancel_outlined, size: 22.h,),
                    ),
                  ],
                ),
                widget.child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
