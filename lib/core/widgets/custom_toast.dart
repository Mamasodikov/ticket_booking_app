import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ticket_booking_app/core/utils/app_constants.dart';
import 'package:ticket_booking_app/core/utils/string_enums.dart';

class CustomToast {
  static void showToast(String text) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 18.0,
    );
  }
}

class SnackToast {
  static void showToast(String text, Color color) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 20.0,
    );
  }
}

Snack(String msg, BuildContext ctx, Color color) {
  var snackBar = SnackBar(
      behavior: SnackBarBehavior.fixed,
      backgroundColor: color,
      content: Text(
        msg,
        textAlign: TextAlign.center,
      ));
  ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
}

SnackAction(
    String msg, BuildContext ctx, Color color, Function fnc, bool isPop) {
  isPop ? Navigator.pop(ctx) : null;

  var snackBar = SnackBar(
      duration: Duration(seconds: 5),
      action: SnackBarAction(
        label: OPEN,
        onPressed: () {
          fnc();
        },
      ),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      content: Text(
        msg,
        style: TextStyle(
            color: cFirstColor, fontSize: 15.sp, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ));
  ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
}
