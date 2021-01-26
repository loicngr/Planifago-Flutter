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

InputDecoration buildInputDecoration(String hint, String iconPath) {
  return InputDecoration(
    focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
            color: Color(ConstantColors.blue)
        )
    ),
    hintText: hint,
    enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
            color: Color(ConstantColors.gray)
        )
    ),
    icon: iconPath != '' ? Image.asset(iconPath) : null,
    errorStyle: TextStyle(color: Color(ConstantColors.saumon)),
    errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
            color:  Color(ConstantColors.saumon)
        )
    ),
    focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
            color:  Color(ConstantColors.saumon)
        )
    ),
  );
}

bool isEmail(String value) {
  String regex =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = new RegExp(regex);

  return value.isNotEmpty && regExp.hasMatch(value);
}

bool isLandscape(BuildContext c) => MediaQuery.of(c).orientation == Orientation.landscape;
EdgeInsets devicePadding(BuildContext c) => MediaQuery.of(c).padding;
double deviceWidth(BuildContext c) => MediaQuery.of(c).size.width - devicePadding(c).left - devicePadding(c).right;
double deviceHeight(BuildContext c) => MediaQuery.of(c).size.height;

double landingLogoBlocHeight(BuildContext c) => deviceHeight(c) / 2;
double landingLogoBlocBtn(BuildContext c) => landingLogoBlocHeight(c) / 2;


getLoader() {
  return Center(
    child: Container(
      width: 50,
      height: 50,
      child: CircularProgressIndicator(),
    ),
  );
}