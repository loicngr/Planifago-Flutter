import 'package:flutter/material.dart';
import 'package:planifago/client_provider.dart';

/**
 * Utils
 */
import 'package:planifago/utils/constants.dart';

/**
 * Screens
 */
import 'package:planifago/screens/home/home_page.dart';
import 'package:planifago/screens/landing/landing_page.dart';

final graphqlEndpoint = ConstantApi.dev_api_address + '/api/graphql';
final subscriptionEndpoint = null;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClientProvider(
      uri: graphqlEndpoint,
      subscriptionUri: subscriptionEndpoint,
      child: MaterialApp(
        title: 'Planifago',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LandingPage(),
      ),
    );
  }
}