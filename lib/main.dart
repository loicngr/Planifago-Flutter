/// Packages
import 'package:flutter/material.dart';
import 'package:planifago/client_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

/// Utils
import 'package:planifago/utils/constants.dart';

/// Router
import 'package:planifago/router.dart' as router;

final graphqlEndpoint = ConstantApi.devApiAddress + '/api/graphql';
final subscriptionEndpoint = null;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DotEnv.load();
  runApp(MyApp());
}

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
