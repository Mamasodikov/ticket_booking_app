import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:slide_action/slide_action.dart';
import 'package:ticket_booking_app/core/utils/app_constants.dart';

class CustomGradientButton extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double height;
  final Gradient gradient;
  final VoidCallback? onPressed;
  final Widget child;

  const CustomGradientButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.borderRadius,
    this.width,
    this.height = 45.0,
    this.gradient = const LinearGradient(colors: [Colors.cyan, Colors.indigo]),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius =
        this.borderRadius ?? BorderRadius.all(Radius.circular(20.r));
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: borderRadius,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
        ),
        child: child,
      ),
    );
  }
}

class CustomGradientButtonAction extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double height;
  final Gradient gradient;
  final VoidCallback? onPressed;
  final VoidCallback? onAction;
  final Widget child;

  const CustomGradientButtonAction({
    Key? key,
    this.onPressed,
    required this.child,
    this.borderRadius,
    this.width,
    this.height = 45.0,
    this.gradient = const LinearGradient(colors: [Colors.cyan, Colors.indigo]),
    this.onAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius =
        this.borderRadius ?? BorderRadius.all(Radius.circular(40.r));
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            color: cSecondGradientColor.withAlpha(200),
            blurRadius: 30.0, // soften the shadow
            spreadRadius: 1.0, //extend the shadow
            offset: Offset(
              0.0, // Move to right 10  horizontally
              10.0, // Move to bottom 10 Vertically
            ),
          )
        ],
      ),
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(borderRadius: borderRadius),
          ),
          child: SlideAction(
            trackBuilder: (context, state) {
              return Center(
                child: AnimatedOpacity(
                  opacity: 1 -
                      subtractWithGeometricProgression(
                          state.thumbFractionalPosition + 0.8, 10, 0.8),
                  duration: Duration(milliseconds: 100),
                  child: child,
                ),
              );
            },
            thumbBuilder: (context, state) {
              return Icon(Icons.swipe_right_alt_rounded);
            },
            action: onAction,
          )),
    );
  }

  double subtractWithGeometricProgression(
      double initialPosition, int numTerms, double commonRatio) {
    double sum = 0.0; // initialize the sum to 0

    // Start the loop from 1 instead of 0 to account for the initial position
    for (int i = 1; i <= numTerms; i++) {
      double term = (1 - initialPosition) *
          pow(commonRatio, i - 1); // calculate the ith term
      sum += term; // add the ith term to the sum
    }

    double newPosition =
        initialPosition - sum; // subtract the sum from the initial position
    newPosition = max(
        0.0,
        min(newPosition,
            1.0)); // clamp the resulting value to the range of 0 to 1

    return newPosition;
  }
}

class CustomSolidButton extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double height;
  final Color color;
  final VoidCallback? onPressed;
  final Widget child;
  final bool hasShadow;

  const CustomSolidButton(
      {Key? key,
      required this.onPressed,
      required this.child,
      this.borderRadius,
      this.width,
      this.height = 45.0,
      this.color = Colors.blue,
      this.hasShadow = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius =
        this.borderRadius ?? BorderRadius.all(Radius.circular(20.r));
    return Container(
      width: width,
      height: height,
      decoration: hasShadow == true
          ? BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: color.withAlpha(100),
                  blurRadius: 20.0, // soften the shadow
                  spreadRadius: 1.0, //extend the shadow
                  offset: Offset(
                    0.0, // Move to right 10  horizontally
                    -0.0, // Move to bottom 10 Vertically
                  ),
                )
              ],
              color: color,
              borderRadius: borderRadius,
            )
          : BoxDecoration(
              color: color,
              borderRadius: borderRadius,
            ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
        ),
        child: child,
      ),
    );
  }
}

class CustomOutlinedButton extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double height;
  final Color color;
  final VoidCallback? onPressed;
  final Widget child;

  const CustomOutlinedButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.borderRadius,
    this.width,
    this.height = 45.0,
    this.color = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius =
        this.borderRadius ?? BorderRadius.all(Radius.circular(20.r));
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
      ),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          side: BorderSide(
            color: Colors.white,
          ),
        ),
        child: child,
      ),
    );
  }
}
