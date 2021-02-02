library planifago.router;

/// Packages
import 'package:flutter/material.dart';

/// Screens
import 'package:planifago/screens/home/home_page.dart';
import 'package:planifago/screens/landing/landing_page.dart';
import 'package:planifago/screens/landing/login_page.dart';
import 'package:planifago/screens/landing/signup_page.dart';

/// Utils - Globals
import 'package:planifago/globals.dart' as globals;
import 'package:planifago/screens/wrapper.dart';

String isEmptyTitle(Map<String, dynamic> params, String name) {
  return (params != null && params.containsKey('title'))
      ? params['title']
      : name;
}

bool isUserConnected() {
  return globals.userIsConnected;
}

PageRouteBuilder<dynamic> routes(BuildContext context, RouteSettings page) {
  Map<String, dynamic> params = {};
  if (page.arguments.toString().isNotEmpty) {
    params = page.arguments as Map<String, dynamic>;
  }

  // TODO - Check if user need to be connected
  switch (page.name) {
    case '/home':
      {
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => HomePage(
            title: isEmptyTitle(params, 'Home'),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = Offset(-1, 0);
            var end = Offset.zero;
            var curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      }
      break;

    case '/signup':
      {
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => SignUpPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = Offset(0, 1);
            var end = Offset.zero;
            var curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      }
      break;

    case '/login':
      {
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = Offset(1, 0);
            var end = Offset.zero;
            var curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      }
      break;

    default:
      {
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => Wrapper(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = Offset(-1, 0);
            var end = Offset.zero;
            var curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      }
      break;
  }
}
