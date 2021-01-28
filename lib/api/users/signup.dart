import 'dart:async';
import 'dart:convert';

/// Packages
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

/// Utils / Globals
import 'package:planifago/globals.dart' as globals;

Future<String> usersSignUp(Map<String, String> values, BuildContext context) async {
  final DateTime date = DateTime.now();
  final String dateStr = date.toString();

  final String email = values['email'];
  final String password = values['password'];
  final String firstname = values['firstname'];
  final String lastname = values['lastname'];

  final String _query = r'''
      mutation createUser ($email: String!, $password: String!, $firstname: String! $lastname: String!, $dateStr: String!) {
        createUser(input: {
          email: $email,
          password: $password,
          firstname: $firstname,
          lastname: $lastname,
          roles: ["ROLE_USER"],
          createdAt: $dateStr,
          updatedAt: $dateStr,
          isActive: false,
          plan: "/api/plans/1",
        }) {
          clientMutationId
          user {
            id
          }
        }
      }
    ''';

  final _client = GraphQLProvider.of(context).value;
  final QueryOptions options = QueryOptions(
    documentNode: gql(_query),
    variables: <String, String>{
      'email': "$email",
      'password': "$password",
      'firstname': "$firstname",
      'lastname': "$lastname",
      'dateStr': "$dateStr",
    },
  );
  final QueryResult r = await _client.query(options);

  if (r.hasException) {
    if (globals.debugMode) { print(r.exception.toString()); }
    return null;
  }

  final String rawResult = jsonEncode(r.data);
  final Map<String, dynamic> result = jsonDecode(rawResult);
  return result['createUser']['user']['id'];
}