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
import 'package:ticket_booking_app/auth/login/presentation/pages/login_page.dart';
import 'package:ticket_booking_app/auth/register/presentation/bloc/register_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  static Widget screen() => BlocProvider(
        create: (context) => di<RegisterBloc>(),
        child: RegisterPage(),
      );

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordRepeat = TextEditingController();
  TextEditingController username = TextEditingController();

  bool _passwordVisible = false;

  late RegisterBloc _bloc;
  SharedPreferences prefs = di();

  @override
  void initState() {
    _bloc = BlocProvider.of<RegisterBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    firstName.dispose();
    lastName.dispose();
    email.dispose();
    password.dispose();
    passwordRepeat.dispose();
    username.dispose();
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
            child: BlocConsumer<RegisterBloc, RegisterState>(
              listener: (context, state) {
                // do stuff here based on Bloc's state
              },
              buildWhen: (previous, current) {
                OverlayState? state = Overlay.of(context);

                if (current is NoConnectionRegister) {
                  WidgetsBinding.instance.addPostFrameCallback((time) {
                    // Snack(
                    //     LocaleKeys.noInternetConnection.tr(), context, cRedColor);
                    showTopSnackBar(
                      state,
                      CustomSnackBar.info(
                        message: noInternetConnection,
                      ),
                    );
                  });
                } else if (current is RegisterFailure) {
                  WidgetsBinding.instance.addPostFrameCallback((time) {
                    // Snack(LocaleKeys.downloadError.tr(), context, cRedColor);
                    showTopSnackBar(
                        state,
                        CustomSnackBar.error(
                          message: current.message,
                        ));
                  });
                } else if (current is ServerError) {
                  WidgetsBinding.instance.addPostFrameCallback((time) {
                    // Snack(LocaleKeys.serverError.tr(), context, cRedColor);
                    showTopSnackBar(
                        state,
                        CustomSnackBar.error(
                          message: serverError,
                        ));
                  });
                }

                if (current is RegisterSuccess) {
                  try {
                    Timer(Duration(milliseconds: 500), () {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.pushReplacement(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => LoginPage.screen(),
                            ));
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
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 25.w),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                  padding: EdgeInsets.only(
                                      left: 50.w, right: 50.w, top: 20.h),
                                  child: Text(
                                    'Register',
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
                                padding:
                                    EdgeInsets.fromLTRB(15.w, 2.h, 5.w, 0.h),
                                child: Center(
                                  child: Row(
                                    children: [
                                      Icon(Icons.person),
                                      SizedBox(
                                        width: 6.w,
                                      ),
                                      Expanded(
                                        child: TextFormField(
                                          keyboardType: TextInputType.name,
                                          cursorColor: cBlackColor,
                                          controller: firstName,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "John",
                                            hintStyle: TextStyle(
                                                fontSize: 24.sp,
                                                color: cGrayColor1,
                                                fontFamily: "Regular"),
                                            prefixIconConstraints:
                                                BoxConstraints(
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
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(cRadius16.r),
                                    color: cWhiteColor,
                                    border: Border.all(
                                        color: Colors.white.withAlpha(80))),
                                height: 70.h,
                                padding:
                                    EdgeInsets.fromLTRB(15.w, 2.h, 5.w, 0.h),
                                child: Center(
                                  child: Row(
                                    children: [
                                      Icon(Icons.person),
                                      SizedBox(
                                        width: 6.w,
                                      ),
                                      Expanded(
                                        child: TextFormField(
                                          keyboardType: TextInputType.name,
                                          cursorColor: cBlackColor,
                                          controller: lastName,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Doe",
                                            hintStyle: TextStyle(
                                                fontSize: 24.sp,
                                                color: cGrayColor1,
                                                fontFamily: "Regular"),
                                            prefixIconConstraints:
                                                BoxConstraints(
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
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(cRadius16.r),
                                    color: cWhiteColor,
                                    border: Border.all(
                                        color: Colors.white.withAlpha(80))),
                                height: 70.h,
                                padding:
                                    EdgeInsets.fromLTRB(15.w, 2.h, 5.w, 0.h),
                                child: Center(
                                  child: Row(
                                    children: [
                                      Icon(Icons.email),
                                      SizedBox(
                                        width: 6.w,
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
                                            prefixIconConstraints:
                                                BoxConstraints(
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
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(cRadius16.r),
                                    color: cWhiteColor,
                                    border: Border.all(
                                        color: Colors.white.withAlpha(80))),
                                height: 70.h,
                                padding:
                                    EdgeInsets.fromLTRB(15.w, 2.h, 5.w, 0.h),
                                child: Center(
                                  child: Row(
                                    children: [
                                      Icon(Icons.alternate_email_rounded),
                                      SizedBox(
                                        width: 6.w,
                                      ),
                                      Expanded(
                                        child: TextFormField(
                                          keyboardType: TextInputType.text,
                                          cursorColor: cBlackColor,
                                          controller: username,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "username",
                                            hintStyle: TextStyle(
                                                fontSize: 24.sp,
                                                color: cGrayColor1,
                                                fontFamily: "Regular"),
                                            prefixIconConstraints:
                                                BoxConstraints(
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
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(cRadius16.r),
                                    color: cWhiteColor,
                                    border: Border.all(
                                        color: Colors.white.withAlpha(80))),
                                height: 70.h,
                                padding:
                                    EdgeInsets.fromLTRB(15.w, 2.h, 5.w, 0.h),
                                child: Center(
                                  child: Row(
                                    children: [
                                      Icon(Icons.password),
                                      SizedBox(
                                        width: 6.w,
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
                                            hintText:
                                                'Think very strong password :)',
                                            hintStyle: TextStyle(
                                                fontSize: 24.sp,
                                                color: cGrayColor1,
                                                fontFamily: "Regular"),
                                            prefixIconConstraints:
                                                BoxConstraints(
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
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(cRadius16.r),
                                    color: cWhiteColor,
                                    border: Border.all(
                                        color: Colors.white.withAlpha(80))),
                                height: 70.h,
                                padding:
                                    EdgeInsets.fromLTRB(15.w, 2.h, 5.w, 0.h),
                                child: Center(
                                  child: Row(
                                    children: [
                                      Icon(Icons.password),
                                      SizedBox(
                                        width: 6.w,
                                      ),
                                      Expanded(
                                        child: TextFormField(
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          cursorColor: cBlackColor,
                                          obscureText: !_passwordVisible,
                                          //This will obscure text dynamically
                                          controller: passwordRepeat,
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
                                            hintText: 'Now repeat..',
                                            hintStyle: TextStyle(
                                                fontSize: 24.sp,
                                                color: cGrayColor1,
                                                fontFamily: "Regular"),
                                            prefixIconConstraints:
                                                BoxConstraints(
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
                                    if (true && password.text.isNotEmpty) {
                                      if (password.text ==
                                          passwordRepeat.text) {
                                        if (password.text.length > 4) {
                                          _bloc.add(SendRegisterEvent(
                                              firstName.text,
                                              lastName.text,
                                              email.text,
                                              username.text,
                                              password.text));
                                        } else {
                                          CustomToast.showToast(
                                              'Password is too short');
                                        }
                                      } else {
                                        CustomToast.showToast(
                                            'Password do not match');
                                      }
                                    } else {
                                      CustomToast.showToast('Fill all fields!');
                                    }
                                  },
                                  child: _button(state, 'REGISTER'),
                                  color: cSecondColor,
                                  hasShadow: true,
                                  height: 70.h,
                                  width: double.infinity),
                            ],
                          )
                              .animate()
                              .fadeIn() // uses `Animate.defaultDuration`
                              .scale(
                                  begin: Offset(0.9, 0.9),
                                  end: Offset(
                                      1, 1)) // inherits duration from fadeIn
                              .shimmer(),
                        ]),
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
    if (state is RegisterLoading) {
      return const CupertinoActivityIndicator(
        color: cBlackColor,
      );
    } else {
      return Text(
        text,
        style: TextStyle(
            fontSize: 25.sp, fontFamily: 'Regular', color: cWhiteColor),
      );
    }
  }
}
