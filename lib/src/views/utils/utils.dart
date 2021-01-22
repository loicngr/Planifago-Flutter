import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planifago/src/views/utils/constants.dart';

class DrawCircle extends CustomPainter {
  Paint _paint;

  DrawCircle() {
    _paint = Paint()
      ..color = Color(ConstantColors.gray)
      ..strokeWidth = 10.0
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(0.0, 0.0), 70.0, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

bool isLandscape(BuildContext c) => MediaQuery.of(c).orientation == Orientation.landscape;
EdgeInsets devicePadding(BuildContext c) => MediaQuery.of(c).padding;
double deviceWidth(BuildContext c) => MediaQuery.of(c).size.width - devicePadding(c).left - devicePadding(c).right;
double deviceHeight(BuildContext c) => MediaQuery.of(c).size.height;

double landingLogoBlocHeight(BuildContext c) => deviceHeight(c) / 2;
double landingLogoBlocBtn(BuildContext c) => landingLogoBlocHeight(c) / 2;