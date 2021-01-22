import 'package:flutter/material.dart';
import 'package:planifago/src/views/ui/landing.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Landing(),
    );
  }
}