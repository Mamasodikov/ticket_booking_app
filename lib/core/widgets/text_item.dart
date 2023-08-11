import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ticket_booking_app/core/utils/app_constants.dart';

Widget textField(
    {required String title,
    String? placeholder,
    Widget? icon,
    TextInputType? keyboardType,
    bool? isEditable,
    required TextEditingController controller}) {
  !(isEditable ?? true) ? controller.text = placeholder ?? '' : null;

  return Container(
    margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
    child: TextField(
      controller: controller,
      enabled: isEditable,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        icon: icon,
        hintText: isEditable ?? true ? placeholder : null,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: cFirstColor)),
        border: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: cFirstColor)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: cFirstColor)),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: cFirstColor)),
        label: Text(
          title,
          style: TextStyle(
              fontFamily: "interMedium", color: cFirstColor, fontSize: 16.sp),
        ),
      ),
    ),
  );
}
