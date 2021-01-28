library planifago.globals;

import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:planifago/api/types/user.dart';

Map<String, String> userTokens = {
  'token': null,
  'refresh_token': null
};

bool userLoginProcess = false;

User userData;

ValueNotifier<GraphQLClient> client;