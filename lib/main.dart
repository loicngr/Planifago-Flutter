import 'dart:async';

/// Packages
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:graphql_flutter/graphql_flutter.dart';

/// Utils
import 'package:planifago/utils/constants.dart';
import 'package:planifago/globals.dart' as globals;

/// Router
import 'package:planifago/router.dart' as router;
import 'package:planifago/utils/utils.dart';

final graphqlEndpoint = ConstantApi.devApiAddress + '/api/graphql';

void main() async {
  await initHiveForFlutter();
  await DotEnv.load();

  final HttpLink httpLink = HttpLink(graphqlEndpoint);

  final AuthLink authLink = AuthLink(
    getToken: () async {
      final token = await JwtUtils.getAccessToken;
      return 'Bearer $token';
    },
  );

  /// Check if user was already connected to app
  /// And
  /// AccessToken is valid
  final FutureOr<String> userBearer = await authLink.getToken();
  if (userBearer.toString().length <= 28) {
    /// If access token not contain JWT
    globals.userIsConnected = false;
  } else {
    globals.userIsConnected = true;
  }

  final Link link = authLink.concat(httpLink);
  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: link,
      cache: GraphQLCache(store: HiveStore()),
    ),
  );

  runApp(MyApp(client));
}

class MyApp extends StatelessWidget {
  MyApp(this.client);

  final ValueNotifier<GraphQLClient> client;

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        title: 'Planifago',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/landing',
        onGenerateRoute: (page) {
          return router.routes(context, page);
        },
      ),
    );
  }
}
