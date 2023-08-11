// Making list of pages needed to pass in IntroViewsFlutter constructor.
import 'package:flutter/material.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:ticket_booking_app/core/utils/app_constants.dart';
import 'package:ticket_booking_app/generated/assets.dart';

final pages = [
  PageViewModel(
    pageColor: cFirstColor,
    // iconImageAssetPath: 'assets/air-hostess.png',
    // bubble: Image.asset(Assets.assetsEvent),
    body: const Text(
      'Hassle-free  booking  of  event  tickets  with  full  refund  on  cancellation',
    ),
    title: const Text(
      'Events',
    ),
    titleTextStyle:
    const TextStyle(fontFamily: Assets.assetsColdesacModernGeometricFont, color: Colors.white),
    bodyTextStyle: const TextStyle(fontFamily: 'MyFont', color: Colors.white),
    mainImage: Image.asset(
     Assets.assetsEvent,
      height: 285.0,
      width: 285.0,
      alignment: Alignment.center,
    ),
  ),
  PageViewModel(
    pageColor: cSecondColor,
    // iconImageAssetPath: 'assets/waiter.png',
    body: const Text(
      'We  work  for  the  comfort ,  use our app easily',
    ),
    title: const Text('Comfortable'),
    mainImage: Image.asset(
      Assets.assetsApp,
      height: 285.0,
      width: 285.0,
      alignment: Alignment.center,
    ),
    titleTextStyle:
    const TextStyle(fontFamily: Assets.assetsColdesacModernGeometricFont, color: Colors.white),
    bodyTextStyle: const TextStyle(fontFamily: 'MyFont', color: Colors.white),
  ),
  PageViewModel(
    pageBackground: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          stops: [0.0, 1.0],
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
          tileMode: TileMode.repeated,
          colors: [
           cFirstColor,
         cSecondColor
          ],
        ),
      ),
    ),
    // iconImageAssetPath: ,
    body: const Text(
      'Easy  ticket  booking  at  your  doorstep  with  cashless  payment  system',
    ),
    title: const Text('Online service'),
    mainImage: Image.asset(
      Assets.assetsPayment,
      height: 285.0,
      width: 285.0,
      alignment: Alignment.center,
    ),
    titleTextStyle:
    const TextStyle(fontFamily: Assets.assetsColdesacModernGeometricFont, color: Colors.white),
    bodyTextStyle: const TextStyle(fontFamily: 'MyFont', color: Colors.white),
  ),
];