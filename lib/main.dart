import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_booking_app/core/di/dependency_injection.dart' as GetIt;
import 'package:ticket_booking_app/core/utils/app_constants.dart';
import 'package:ticket_booking_app/auth/login/presentation/pages/login_page.dart';
import 'package:ticket_booking_app/events/presentation/pages/events_page.dart';
import 'package:ticket_booking_app/intro_page.dart';
import 'package:ticket_booking_app/navigation/navigation.dart';

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await GetIt.init();
    runApp(MyApp());
  }, (error, stacktrace) {
    log('runZonedGuarded Errors: $error');
    debugPrint("Ticket Booking app error");
  });
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final SharedPreferences sharedPreferences = GetIt.di();

  // This widget is the root of your application.

  


  @override
  Widget build(BuildContext context) {
    bool hasToken = sharedPreferences.getString("token") != null ? true : false;

    return ScreenUtilInit(
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
            title: 'Ticket Booking App',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: cSecondColor,
                primary: cFirstColor,
              ),
              useMaterial3: true,
            ),
            debugShowCheckedModeBanner: false,
            builder: (context, widget) {
              ScreenUtil.init(
                context,
                designSize: const Size(428, 926),
                minTextAdapt: true,
              );
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: widget!,
              );
            },
            home: hasToken ? BottomNavigationPage() : Builder(
              builder: (context) => IntroViewsFlutter(
                pages,
                showNextButton: true,
                showBackButton: true,
                onTapDoneButton: () {
                  // Use Navigator.pushReplacement if you want to dispose the latest route
                  // so the user will not be able to slide back to the Intro Views.
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => LoginPage.screen()),
                  );
                },
                pageButtonTextStyles: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ),
        );
      },
    );
  }
}
