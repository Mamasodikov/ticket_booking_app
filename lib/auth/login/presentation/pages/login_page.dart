import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticket_booking_app/core/di/dependency_injection.dart';
import 'package:ticket_booking_app/core/utils/app_constants.dart';
import 'package:ticket_booking_app/core/utils/string_enums.dart';
import 'package:ticket_booking_app/core/widgets/custom_material_button.dart';
import 'package:ticket_booking_app/core/widgets/custom_toast.dart';
import 'package:ticket_booking_app/auth/login/presentation/bloc/login_bloc.dart';
import 'package:ticket_booking_app/events/presentation/pages/events_page.dart';
import 'package:ticket_booking_app/navigation/navigation.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../../register/presentation/pages/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static Widget screen() => BlocProvider(
        create: (context) => di<LoginBloc>(),
        child: LoginPage(),
      );

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool _passwordVisible = false;
  final ValueNotifier<bool> written = ValueNotifier(false);

  late LoginBloc _bloc;
  SharedPreferences prefs = di();

  @override
  void initState() {
    _bloc = BlocProvider.of<LoginBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: cWhiteColor,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                // do stuff here based on Bloc's state
              },
              buildWhen: (previous, current) {
                OverlayState? state = Overlay.of(context);

                if (current is NoConnectionLogin) {
                  WidgetsBinding.instance.addPostFrameCallback((time) {
                    // Snack(LocaleKeys.noInternetConnection.tr(), context,
                    //     cRedColor);
                    showTopSnackBar(
                      state,
                      CustomSnackBar.info(
                        message: noInternetConnection,
                      ),
                    );
                  });
                } else if (current is LoginFailure) {
                  WidgetsBinding.instance.addPostFrameCallback((time) {
                    // SnackToast.showToast(LocaleKeys.downloadError.tr(), cRedColor);
                    // Snack(LocaleKeys.downloadError.tr(), context, cRedColor);
                    showTopSnackBar(
                      state,
                      CustomSnackBar.error(
                        message: current.message,
                      ),
                    );
                  });
                } else if (current is ServerError) {
                  WidgetsBinding.instance.addPostFrameCallback((time) {
                    // SnackToast.showToast(LocaleKeys.serverError.tr(), cRedColor);
                    // Snack(LocaleKeys.serverError.tr(), context, cRedColor);
                    showTopSnackBar(
                      state,
                      CustomSnackBar.error(
                        message: serverError,
                      ),
                    );
                  });
                } else if (current is PasswordError) {
                  WidgetsBinding.instance.addPostFrameCallback((time) {
                    // SnackToast.showToast(LocaleKeys.passwordNotMatch.tr(), cRedColor);
                    // Snack(LocaleKeys.passwordNotMatch.tr(), context, cRedColor);
                    showTopSnackBar(
                      state,
                      CustomSnackBar.error(
                        message: passwordNotMatch,
                      ),
                    );
                  });
                } else if (current is NoUser) {
                  WidgetsBinding.instance.addPostFrameCallback((time) {
                    // SnackToast.showToast(LocaleKeys.noSuchUser.tr(), cRedColor);
                    // Snack(LocaleKeys.noSuchUser.tr(), context, cRedColor);
                    showTopSnackBar(
                      state,
                      CustomSnackBar.info(
                        message: noSuchUser,
                      ),
                    );
                  });
                }
                if (current is LoginSuccess) {
                  try {
                    Timer(Duration(milliseconds: 500), () {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                              builder: (context) =>
                                 BottomNavigationPage()),
                        );
                      });
                    });
                    return false;
                  } catch (e) {
                    return true;
                  }
                }

                return true;
              },
              builder: (context, state) {
                return Stack(children: [
                  Container(
                    decoration: BoxDecoration(color: cFirstColor),
                  ),

                  // SizedBox(
                  //   height: 20.h,
                  // ),
                  // TextFormField(
                  //   cursorColor: cFirstColor,
                  //   controller: url,
                  //   style: TextStyle(
                  //       fontSize: 30.sp,
                  //       color: cWhiteColor,
                  //       fontFamily: "Regular"),
                  // ),

                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 25.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Spacer(
                          flex: 2,
                        ),
                        Text(
                          'For using application, register or login!',
                          style: TextStyle(
                              fontSize: 30.sp,
                              fontWeight: FontWeight.w600,
                              color: cWhiteColor),
                          textAlign: TextAlign.center,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 40.h,
                            ),
                            Container(
                                padding: EdgeInsets.only(
                                    left: 50.w, right: 50.w, top: 20.h),
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.w600,
                                      color: cWhiteColor),
                                  textAlign: TextAlign.center,
                                )),
                            SizedBox(
                              height: 40.h,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(cRadius16.r),
                                  color: cWhiteColor,
                                  border: Border.all(
                                      color: Colors.white.withAlpha(80))),
                              height: 70.h,
                              padding: EdgeInsets.fromLTRB(15.w, 2.h, 5.w, 0.h),
                              child: Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.email),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        cursorColor: cBlackColor,
                                        controller: email,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "example@mail.com",
                                          hintStyle: TextStyle(
                                              fontSize: 24.sp,
                                              color: cGrayColor1,
                                              fontFamily: "Regular"),
                                          prefixIconConstraints: BoxConstraints(
                                            maxWidth: 30.w,
                                            maxHeight: 30.h,
                                            minHeight: 25.h,
                                            minWidth: 25.w,
                                          ),
                                        ),
                                        style: TextStyle(
                                            fontSize: 24.sp,
                                            color: cBlackColor,
                                            fontFamily: "Regular"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(cRadius16.r),
                                  color: cWhiteColor,
                                  border: Border.all(
                                      color: Colors.white.withAlpha(80))),
                              height: 70.h,
                              padding: EdgeInsets.fromLTRB(15.w, 2.h, 5.w, 0.h),
                              child: Center(
                                child: Row(
                                  children: [
                                    Icon(Icons.password),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        cursorColor: cBlackColor,
                                        obscureText: !_passwordVisible,
                                        //This will obscure text dynamically
                                        controller: password,
                                        decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              // Based on passwordVisible state choose the icon
                                              _passwordVisible
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: cFirstColor,
                                            ),
                                            onPressed: () {
                                              // Update the state i.e. toogle the state of passwordVisible variable
                                              setState(() {
                                                _passwordVisible =
                                                    !_passwordVisible;
                                              });
                                            },
                                          ),
                                          border: InputBorder.none,
                                          hintText: '******',
                                          hintStyle: TextStyle(
                                              fontSize: 24.sp,
                                              color: cGrayColor1,
                                              fontFamily: "Regular"),
                                          prefixIconConstraints: BoxConstraints(
                                            maxWidth: 30.w,
                                            maxHeight: 30.h,
                                            minHeight: 25.h,
                                            minWidth: 25.w,
                                          ),
                                        ),
                                        style: TextStyle(
                                            fontSize: 24.sp,
                                            color: cBlackColor,
                                            fontFamily: "Regular"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            CustomSolidButton(
                                onPressed: () {
                                  ///Email validator
                                  if (true) {
                                    if (email.text.isNotEmpty) {
                                      _bloc.add(SendLoginEvent(
                                        email.text,
                                        password.text,
                                      ));
                                    } else {
                                      CustomToast.showToast('Email is empty!');
                                    }
                                  } else {
                                    CustomToast.showToast('text8');
                                  }
                                },
                                child: _button(state, 'LOGIN'),
                                color: cSecondColor,
                                hasShadow: true,
                                height: 70.h,
                                width: double.infinity),

                            ///Replace Container
                            // Flexible(
                            //   child: TextButton(
                            //       onPressed: () {
                            //         Navigator.push(
                            //             context,
                            //             CupertinoPageRoute(
                            //                 builder: (context) => Container()));
                            //       },
                            //       child: Align(
                            //         alignment: Alignment.topRight,
                            //         child: Text(
                            //           'text9',
                            //           style: TextStyle(
                            //               color: cYellowColor, fontSize: 20.sp),
                            //         ),
                            //       )),
                            // ),

                            SizedBox(
                              height: 10.h,
                            ),
                            Flexible(
                              child: CustomOutlinedButton(
                                  height: 70.h,
                                  width: double.infinity,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) =>
                                                RegisterPage.screen()));
                                  },
                                  color: cFirstColor,
                                  child: Text(
                                    'REGISTER',
                                    style: TextStyle(
                                        color: cWhiteColor, fontSize: 25.sp),
                                  )),
                            ),
                          ],
                        )
                            .animate()
                            .fadeIn() // uses `Animate.defaultDuration`
                            .scale(
                                begin: Offset(0.9, 0.9),
                                end: Offset(
                                    1, 1)) // inherits duration from fadeIn
                            .shimmer(),
                        Spacer(
                          flex: 3,
                        ),
                      ],
                    ),
                  ),
                ]);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _button(state, String text) {
    if (state is LoginLoading) {
      return const CupertinoActivityIndicator(
        color: cBlackColor,
      );
    } else {
      return Text(
        text,
        style: TextStyle(
          color: cWhiteColor,
          fontSize: 25.sp,
          fontFamily: 'Regular',
        ),
      );
    }
  }
}
