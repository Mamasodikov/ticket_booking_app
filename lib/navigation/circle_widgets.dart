import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ticket_booking_app/core/utils/app_constants.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class CirclePlusWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      child: Container(
        height: 80,
        width: 80,
        child: Stack(
          children: [
            // Transparent circle as background
            Align(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    width: 75,
                    height: 75,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: cNephriteColor.withAlpha(100)),
                    child: Center(
                      child: Icon(Icons.add, color: Colors.white, size: 25),
                    ),
                  ),
                ),
              ),
            ),
            // Gradient circle with plus icon
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 60,
                height: 60,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, gradient: cSecondGradient),
                child: Center(
                  child: Icon(Icons.add, color: Colors.white, size: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CircleHomeWidget extends StatelessWidget {
  final Color iconColor;

  const CircleHomeWidget({super.key, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: cWhiteColor,
          boxShadow: [
            BoxShadow(
              color: cFirstColor.withAlpha(30),
              blurRadius: 10.0, // soften the shadow
              spreadRadius: 3.0, //extend the shadow
              offset: Offset(
                0.0, // Move to right 10  horizontally
                5.0, // Move to bottom 10 Vertically
              ),
            )
          ],
        ),
        child: Center(
          child: Icon(Icons.home),
        ),
      ),
    );
  }
}
