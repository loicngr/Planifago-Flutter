import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:planifago/src/views/utils/constants.dart';

Future<http.Response> logUser(Map<dynamic, dynamic> data) {
  final String email = data['email'];
  final String password = data['password'];

  final apiUrl = ConstantApi.dev_api_address + '/api/login_check';
  return http.post(
      apiUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': email,
        'password': password
      }),
  );
}