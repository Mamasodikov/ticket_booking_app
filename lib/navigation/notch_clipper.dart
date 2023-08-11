import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NotchClipper extends CustomClipper<Path> {
  final double radius;

  NotchClipper({this.radius = 10.0});

  @override
  getClip(Size size) {

    Path path_0 = Path();
    path_0.moveTo(size.width*0.3921387,size.height*0.2498291);
    path_0.cubicTo(size.width*0.3780853,size.height*0.1215886,size.width*0.3543547,0,size.width*0.3239040,0);
    path_0.lineTo(size.width*0.2054651,0);
    path_0.cubicTo(size.width*0.1112064,0,size.width*0.06407733,0,size.width*0.03379547,size.height*0.1330038);
    path_0.cubicTo(size.width*0.03179627,size.height*0.1417848,size.width*0.02986933,size.height*0.1509316,size.width*0.02801947,size.height*0.1604215);
    path_0.cubicTo(0,size.height*0.3041646,0,size.height*0.5278785,0,size.height*0.9753089);
    path_0.cubicTo(0,size.height*0.9866354,0,size.height*0.9923000,size.width*0.0007093520,size.height*0.9959392);
    path_0.cubicTo(size.width*0.0007561867,size.height*0.9961785,size.width*0.0008049653,size.height*0.9964101,size.width*0.0008555813,size.height*0.9966329);
    path_0.cubicTo(size.width*0.001622208,size.height,size.width*0.002815360,size.height,size.width*0.005201627,size.height);
    path_0.lineTo(size.width*0.9947973,size.height);
    path_0.cubicTo(size.width*0.9971840,size.height,size.width*0.9983787,size.height,size.width*0.9991440,size.height*0.9966329);
    path_0.cubicTo(size.width*0.9991947,size.height*0.9964101,size.width*0.9992427,size.height*0.9961785,size.width*0.9992907,size.height*0.9959392);
    path_0.cubicTo(size.width,size.height*0.9923000,size.width,size.height*0.9866354,size.width,size.height*0.9753089);
    path_0.cubicTo(size.width,size.height*0.5278785,size.width,size.height*0.3041646,size.width*0.9719813,size.height*0.1604215);
    path_0.cubicTo(size.width*0.9701307,size.height*0.1509316,size.width*0.9682027,size.height*0.1417848,size.width*0.9662053,size.height*0.1330038);
    path_0.cubicTo(size.width*0.9359227,0,size.width*0.8887947,0,size.width*0.7945360,0);
    path_0.lineTo(size.width*0.6734293,0);
    path_0.cubicTo(size.width*0.6429787,0,size.width*0.6192480,size.height*0.1215885,size.width*0.6051947,size.height*0.2498291);
    path_0.cubicTo(size.width*0.5851973,size.height*0.4323241,size.width*0.5449973,size.height*0.5569620,size.width*0.4986667,size.height*0.5569620);
    path_0.cubicTo(size.width*0.4523360,size.height*0.5569620,size.width*0.4121360,size.height*0.4323241,size.width*0.3921387,size.height*0.2498291);
    path_0.close();

    return path_0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
