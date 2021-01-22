import 'package:flutter/material.dart';
import 'package:planifago/src/views/ui/landing.dart';
import 'package:planifago/src/views/ui/login.dart';

Route landingRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Landing(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}

Route landingSignInRoute({List<dynamic> users}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Login(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}