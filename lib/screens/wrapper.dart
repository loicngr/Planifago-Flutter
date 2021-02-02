/// Packages
import 'package:flutter/material.dart';
import 'package:planifago/screens/home/home_page.dart';
import 'package:planifago/screens/landing/landing_page.dart';

/// Utils
import 'package:planifago/utils/utils.dart';

class Wrapper extends StatelessWidget {
  final Future<bool> _initialization = UserUtils.isConnectedAsync();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (
          BuildContext context,
          AsyncSnapshot<dynamic> snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data) {
              return HomePage(title: 'Home');
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return getLoader;
          }

          return LandingPage();
        });
  }
}
