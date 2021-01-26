import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:planifago/src/views/utils/constants.dart';

Future<http.Response> logUser(String username, String password) {
  final apiUrl = ConstantApi.dev_api_address + '/api/login_check';
  return http.post(
      apiUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password
      }),
  );
}