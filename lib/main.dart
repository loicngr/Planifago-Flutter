/// Packages
import 'package:flutter/material.dart';
import 'package:planifago/client_provider.dart';
import 'package:planifago/router.dart' as router;

/// Utils
import 'package:planifago/utils/constants.dart';

final graphqlEndpoint = ConstantApi.dev_api_address + '/api/graphql';
final subscriptionEndpoint = null;

void main() => runApp(MyApp());

/*
  TODO
    - Check if an JWT are already stored
    - Try to log user with JWT
 */

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
        initialRoute: '/landing',
        onGenerateRoute: (page) {
          return router.routes(page);
        },
      ),
    );
  }
}