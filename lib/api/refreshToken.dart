import 'dart:async';
import 'dart:convert';

/// Packages
import 'package:http/http.dart' as http;
import 'package:planifago/utils/constants.dart';

Future<http.Response> refreshToken(String refreshToken) {
  final apiUrl = ConstantApi.devApiAddress + '/api/token/refresh';
  return http.post(
    apiUrl,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'refresh_token': refreshToken}),
  );
}
