import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

Future<Map<String, dynamic>> usersInformation(String id, BuildContext context) async {
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
    print(r.exception.toString());
    return null;
  }

  final String rawResult = jsonEncode(r.data);
  final Map<String, dynamic> result = jsonDecode(rawResult);
  return result['user'];
}