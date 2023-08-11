import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_booking_app/auth/login/presentation/pages/login_page.dart';
import 'package:ticket_booking_app/core/di/dependency_injection.dart';
import 'package:ticket_booking_app/core/utils/app_constants.dart';
import 'package:ticket_booking_app/core/utils/string_enums.dart';
import 'package:ticket_booking_app/core/widgets/custom_material_button.dart';

class AccoutPage extends StatefulWidget {
  const AccoutPage({super.key});

  @override
  State<AccoutPage> createState() => _AccoutPageState();
}

class _AccoutPageState extends State<AccoutPage> {
  SharedPreferences prefs = di();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cFirstColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: cWhiteColor),
        backgroundColor: cSecondColor,
        title: Text(
          'Account',
          style: TextStyle(color: cWhiteColor),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: double.infinity,
            decoration: BoxDecoration(
                color: cSecondColor,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30.r),
                    bottomLeft: Radius.circular(30.r))),
            child: Center(
              child: CircleAvatar(
                minRadius: 80,
                maxRadius: 100,
                backgroundImage: NetworkImage(placeholderAvatar),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              children: [
                CustomSolidButton(
                    onPressed: () {},
                    color: cSecondColor,
                    width: double.infinity,
                    child: Text(
                      'Update picture',
                      style: TextStyle(color: cWhiteColor),
                    )),
                SizedBox(
                  height: 20.h,
                ),
                CustomSolidButton(
                    onPressed: () {},
                    color: cSecondColor,
                    width: double.infinity,
                    child: Text(
                      'Change Password',
                      style: TextStyle(color: cWhiteColor),
                    )),
                SizedBox(
                  height: 20.h,
                ),
                CustomSolidButton(
                    onPressed: () {
                      logout();
                    },
                    color: cBrownDark,
                    width: double.infinity,
                    child: Text(
                      'Logout',
                      style: TextStyle(color: cWhiteColor),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  logout() {
    showDialog(
        context: context,
        builder: (_) => BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r)),
                backgroundColor: cWhiteColor,
                title: Text('Do u want to exit app?'),
                content: Column(mainAxisSize: MainAxisSize.min, children: [
                  Text(
                    'Your data would not be deleted!',
                    style: TextStyle(color: cRedColor),
                  ),
                ]),
                actions: <Widget>[
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    elevation: 0,
                    color: Colors.green.shade50,
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text(
                      NO,
                      style: TextStyle(color: cGreenColor),
                    ),
                  ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    elevation: 0,
                    color: Colors.red.shade50,
                    onPressed: () async {
                      ///Here is logging out
                      prefs.remove('token');
                      prefs.remove('session');
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginPage.screen()),
                      );
                    },
                    child: Text(
                      YES,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
                actionsPadding: const EdgeInsets.all(10),
              ),
            ));
  }
}
