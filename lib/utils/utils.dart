import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:planifago/utils/constants.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class DrawCircle extends CustomPainter {
  Paint _paint;

  DrawCircle() {
    _paint = Paint()
      ..color = Color(ConstantColors.gray)
      ..strokeWidth = 10.0
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(0.0, 0.0), 70.0, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

InputDecoration buildInputDecoration(String hint, String iconPath) {
  return InputDecoration(
    focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
            color: Color(ConstantColors.blue)
        )
    ),
    hintText: hint,
    enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
            color: Color(ConstantColors.gray)
        )
    ),
    icon: iconPath != '' ? Image.asset(iconPath) : null,
    errorStyle: TextStyle(color: Color(ConstantColors.saumon)),
    errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
            color:  Color(ConstantColors.saumon)
        )
    ),
    focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
            color:  Color(ConstantColors.saumon)
        )
    ),
  );
}

bool isEmail(String value) {
  String regex =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = new RegExp(regex);

  return value.isNotEmpty && regExp.hasMatch(value);
}

bool isLandscape(BuildContext c) => MediaQuery.of(c).orientation == Orientation.landscape;
EdgeInsets devicePadding(BuildContext c) => MediaQuery.of(c).padding;
double deviceWidth(BuildContext c) => MediaQuery.of(c).size.width - devicePadding(c).left - devicePadding(c).right;
double deviceHeight(BuildContext c) => MediaQuery.of(c).size.height;

double landingLogoBlocHeight(BuildContext c) => deviceHeight(c) / 2;
double landingLogoBlocBtn(BuildContext c) => landingLogoBlocHeight(c) / 2;


get getLoader {
  return Center(
    child: Container(
      width: 50,
      height: 50,
      child: CircularProgressIndicator(),
    ),
  );
}

class RouterUtils {
  static resetRoute(BuildContext c, route) {
    return Navigator.of(c).pushAndRemoveUntil(route, (route) => false);
  }
}

class JwtUtils {
  static Map<String, dynamic> decode(token) {
    return JwtDecoder.decode(token);
  }
}

class ConfigUtils {
  static final HttpLink httpLink = HttpLink(
    uri: ConstantApi.dev_api_address + '/api/graphql',
  );

  static  String _token;
  static final AuthLink authLink = AuthLink(getToken: () => _token);

  static final Link link = authLink.concat(httpLink);

  String token;
  static  ValueNotifier<GraphQLClient> initializeClient(String token) {
    _token = token;
    ValueNotifier<GraphQLClient> client =
    ValueNotifier(
      GraphQLClient(
        cache: OptimisticCache(dataIdFromObject:typenameDataIdFromObject),
        link: link,
      ),
    );
    return client;
  }
}

class StorageUtils {
  static final _storage = new FlutterSecureStorage();

  static Future<Map<dynamic, dynamic>> get userJWT async {
    var user = await _storage.read(key: "userJWT");
    if (user == null) return null;
    return jsonDecode(user);
  }

  static Future<bool> save(String key, String value) async {
    try {
      await _storage.write(key: key, value: value);
    } catch(e) {
      print(e);
      return false;
    }
    return true;
  }

  static Future<bool> delete(String key) async {
    try {
      await _storage.delete(key: key);
    } catch(e) {
      print(e);
      return false;
    }
    return true;
  }
}