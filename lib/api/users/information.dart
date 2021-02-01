import 'dart:async';
import 'dart:convert';

/// Packages
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

/// Utils / Globals
import 'package:planifago/globals.dart' as globals;

Future<Map<String, dynamic>> usersInformation(
    String id, BuildContext context) async {
  final String _query = r'''
  query user ($URI: ID!) {
    user(id: $URI) {
      id,
      plan { id },
      email,
      roles,
      firstname,
      lastname,
      phone,
      isActive,
      avatar,
      createdAt,
      updatedAt
    }
  }
  ''';

  final _client = GraphQLProvider.of(context).value;
  final QueryOptions options = QueryOptions(
    documentNode: gql(_query),
    variables: <String, String>{
      'URI': "$id",
    },
  );

  final QueryResult r = await _client.query(options);

  if (r.hasException) {
    if (globals.debugMode) {
      print(r.exception.toString());
    }
    return null;
  }

  final String rawResult = jsonEncode(r.data);
  final Map<String, dynamic> result = jsonDecode(rawResult);
  return result['user'];
}
