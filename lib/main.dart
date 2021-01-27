import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:planifago/src/app.dart';
import 'package:planifago/src/views/utils/constants.dart';
import 'package:planifago/src/globals.dart' as globals;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final HttpLink httpLink = HttpLink(
    uri: ConstantApi.dev_api_address + '/api/graphql',
  );

  final AuthLink authLink = AuthLink(
    getToken: () => 'Bearer ' + globals.userTokens['token'],
  );

  final Link link = authLink.concat(httpLink);

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      cache: InMemoryCache(),
      link: httpLink,
    ),
  );

  runApp(App(client: client));
}