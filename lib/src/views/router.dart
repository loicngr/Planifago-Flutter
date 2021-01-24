import 'package:flutter/material.dart';
import 'package:planifago/src/views/ui/landing.dart';
import 'package:planifago/src/views/ui/login.dart';
import 'package:planifago/src/views/ui/signup.dart';

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

Route landingSignUpRoute({List<dynamic> users}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => SignUp(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}