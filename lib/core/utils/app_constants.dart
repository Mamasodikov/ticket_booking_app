import 'package:flutter/material.dart';

import 'color_ext.dart';

// Platform colors
const cFirstColor = Color(0xFF5E7988);
const cSecondColor = Color(0xFF1E695A);

//Rare colors
const cSecondColorPale = Color(0xFFC1FFF3);
const cCyanColor = Color(0xFF12BED6);
const cNephriteColor = Color(0xFF13CFAA);
const cFirstGradientColor = Color(0xFF00EAFF);
const cSecondGradientColor = Color(0xFF3C8CE7);

//Natural colors
const cBlackColor = Color(0xFF000000);
const cWhiteColor = Color(0xFFFFFFFF);
const cGreenColor = Color(0xFF009676);
const cRedColor = Color(0xFFFF3030);
const cPurpleColor = Color(0xFF7300FF);
const cPinkColor = Color(0xFFB000AB);

//Gray shades
const cGrayColor = Color(0xFFE3EAEF);
const cGrayColor1 = Color(0xFF949494);
const cGrayColor2 = Color(0xFF4F4F4F);
const cGrayColor4 = Color(0xFF333333);
const cGrayColor5 = Color(0xFF596063);
const cGrayColor6 = Color(0xFFD0D0D0);
const cGrayColor7 = Color(0xFFF7F7F7);
const cGrayColor8 = Color(0xFFBBBFC8);
const cGrayColor9 = Color(0xFF595F62);
const cGrayColor10 = Color(0xFF323232);

//Back colors
const cTextColor = Color(0xFF475E6A);
const cBackColor = Color(0xFFF3F3F3);
const cBackInputColor = Color(0xFFFAFAFA);
const cBackButtonColor = Color(0xFFE9F8FF);
const cBackColorIcon = Color(0xFFEFF2FF);
const cGifBackground = Color(0xFFEEF6F9);
const cBlackTextColor = Color(0xFF595F62);

//Hot colors
const cYellowColor = Color(0xFFFCFF52);
const cDarkYellowColor = Color(0xFFFECD00);
const cOrangeColor = Color(0xFFFF9800);
const cBrownLight = Color(0xFFFF5454);
const cBrownDark = Color(0xFFC73E3E);

//Cold colors
const cDarkPurple = Color(0xFF1010A1);
const cBlueColor = Color(0xFF1091EF);
const cDarkBlue = Color(0xFF021A58);
const cDashBoard = Color(0xFF1E59F5);
const cMaterialTextField = Color(0xFF2176D7);
const cBlueLight = Color(0xFFEFF7FF);
const cBlueLight2 = Color(0xFFC4E7FF);

get cFirstTileColor => HexColor.fromHex('#FC6087');

get cSecondTileColor => HexColor.fromHex('#0DB8DC');

get cThirdTileColor => HexColor.fromHex('#868FF8');

get cFourthTileColor => HexColor.fromHex('#629AFB');

get cFifthTileColor => HexColor.fromHex('#0DB8DC');

get cSixthTileColor => HexColor.fromHex('#868FF8');

get cSeventhTileColor => HexColor.fromHex('#629AFB');

get cEighthTileColor => HexColor.fromHex('#629AFB');

get cNinthTileColor => HexColor.fromHex('#0DB8DC');

// All gradient
const cFirstGradient = LinearGradient(
  colors: [Color(0xFF81C5F6), Color(0xFF1091EF)],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

const cSecondGradient = LinearGradient(
  colors: [Color(0xFF5E7988), Color(0xFF1E695A)],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

const cThirdGradient = LinearGradient(
  colors: [Color(0xFF12BED6), Color(0xFF13CFAA)],
  begin: Alignment.bottomCenter,
  end: Alignment.topCenter,
);

// All sizes
const double cRadius8 = 8.0;
const double cRadius10 = 10.0;
const double cRadius12 = 12.0;
const double cRadius16 = 16.0;
const double cRadius22 = 22.0;

const double cNumberLockW90 = 95.0;
const double cNumberLockH90 = 90.0;
const double cNumberLockText42 = 42.0;

// time consts

const String eventsTime = 'events_time';
const String reserveTime = 'events_time';

// versions
String version = "app_version";
String defaultPhone = "1234567";
String defaultManual = "manual.uz";

// lock number style

const numStyle =
    TextStyle(fontSize: 30, fontWeight: FontWeight.w400, color: cWhiteColor);

//Tokens

const String bearerToken = "bearer_token";
final GlobalKey<NavigatorState> navigatorKey =
    GlobalKey(debugLabel: "Main Navigator"); //
