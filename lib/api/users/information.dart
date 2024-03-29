import 'dart:async';
import 'dart:convert';
import 'dart:io';

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
    document: gql(_query),
    variables: <String, String>{
      'URI': "$id",
    },
  );

  QueryResult r;
  try {
    r = await _client.query(options);
  } on SocketException catch (e) {
    if (globals.debugMode) print(e);
    return null;
  } on FormatException catch (e) {
    if (globals.debugMode) print(e);
    return null;
  } on Exception catch (e) {
    if (globals.debugMode) print(e);
    return null;
  }

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
