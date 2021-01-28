/// Packages
import 'package:flutter/material.dart';

/// Screens
import 'package:planifago/screens/home/home_page.dart';
import 'package:planifago/screens/landing/landing_page.dart';
import 'package:planifago/screens/landing/login_page.dart';
import 'package:planifago/screens/landing/signup_page.dart';

Route landingRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => LandingPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(-1, 0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route landingLogInRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1, 0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route landingSignUpRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => SignUpPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0, 1);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route homeRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => HomePage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(-1, 0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}