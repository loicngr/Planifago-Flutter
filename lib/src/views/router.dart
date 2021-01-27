import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:planifago/src/views/ui/home.dart';
import 'package:planifago/src/views/ui/landing/forgot_password.dart';
import 'package:planifago/src/views/ui/landing/landing.dart';
import 'package:planifago/src/views/ui/landing/login.dart';
import 'package:planifago/src/views/ui/landing/signup.dart';

Route landingRoute(ValueNotifier<GraphQLClient> client) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Landing(client: client),
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

Route landingSignInRoute(ValueNotifier<GraphQLClient> client) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Login(client: client),
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

Route landingSignUpRoute(ValueNotifier<GraphQLClient> client) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => SignUp(client: client),
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

Route landingForgotPasswordRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => ForgotPassword(),
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

Route homeRoute(ValueNotifier<GraphQLClient> client) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Home(client: client),
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