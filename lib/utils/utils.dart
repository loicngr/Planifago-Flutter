import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'dart:ui';

/// Packages
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:hive/hive.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Api
import 'package:planifago/api/refreshToken.dart';

/// Utils
import 'package:planifago/utils/constants.dart';
import 'package:planifago/globals.dart' as globals;

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
        borderSide: BorderSide(color: Color(ConstantColors.blue))),
    hintText: hint,
    enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Color(ConstantColors.gray))),
    icon: iconPath != '' ? Image.asset(iconPath) : null,
    errorMaxLines: 5,
    errorStyle: TextStyle(color: Color(ConstantColors.saumon), fontSize: 14.00),
    errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Color(ConstantColors.saumon))),
    focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Color(ConstantColors.saumon))),
  );
}

BottomNavigationBarItem buildbottomNavigationBarItem(
    String label, String iconPath) {
  return BottomNavigationBarItem(
      label: label,
      icon: iconPath != '' ? Image.asset(iconPath) : Icon(Icons.help));
}

bool isEmail(String value) {
  String regex =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = new RegExp(regex);

  return value.isNotEmpty && regExp.hasMatch(value);
}

bool isLandscape(BuildContext c) =>
    MediaQuery.of(c).orientation == Orientation.landscape;
EdgeInsets devicePadding(BuildContext c) => MediaQuery.of(c).padding;
double deviceWidth(BuildContext c) =>
    MediaQuery.of(c).size.width -
    devicePadding(c).left -
    devicePadding(c).right;
double deviceHeight(BuildContext c) => MediaQuery.of(c).size.height;

double landingLogoBlocHeight(BuildContext c) =>
    (deviceHeight(c) - landingLanguageHeight(c)) / 2;
double landingLogoBlocBtn(BuildContext c) => landingLogoBlocHeight(c) / 2;
double landingLanguageHeight(BuildContext c) => devicePadding(c).top + 50;

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
  static resetRoute(BuildContext c, String newRouteName) {
    Navigator.of(c).pushNamedAndRemoveUntil(newRouteName, (route) => false);
  }
}

class UserUtils {
  static bool isConnected() {
    return globals.userIsConnected;
  }

  static Future<bool> isConnectedAsync() async {
    final String accessToken = await JwtUtils.getAccessToken;
    return (accessToken.length > 28) ? true : false;
  }

  static Future<bool> disconnectAsync(context) async {
    await StorageUtils.deleteBox('jwt');
    await StorageUtils.deleteBox('user');
    globals.userIsConnected = false;
    return true;
  }

  static void disconnect(context) {
    globals.userIsConnected = false;
  }
}

Future<Locale> get getAppDefaultLocale async {
  return await StorageUtils.get('settings', 'locale');
}

class RequestUtils {
  /// Launchs a function with these parameters
  /// context - The app context
  /// func - The function that will be called
  /// params - Array of parameters
  static Future<dynamic> tryCatchRequest(
      dynamic context, Function func, List params) async {
    var r;
    try {
      r = await Function.apply(func, params);
    } on SocketException {
      if (context != null) {
        AlertUtils.showMyDialog(
            context, "Login status", "No Internet connection 😑");
      }
      return null;
    } on FormatException {
      if (context != null) {
        AlertUtils.showMyDialog(
            context, "Login status", "Bad response format 👎");
      }
      return null;
    } on Exception {
      if (context != null) {
        AlertUtils.showMyDialog(context, "Login status", "Unexpected error 😢");
      }
      return null;
    }
    return r;
  }
}

class JwtUtils {
  static Future<dynamic> get getAccessToken async {
    String accessToken = '';
    Map<dynamic, dynamic> userJWT = await StorageUtils.getBox('jwt');

    if (userJWT.isNotEmpty)
      accessToken = userJWT['token'];
    else
      return accessToken;

    Map<String, dynamic> parsedAccessToken = decode(accessToken);
    String userRefreshToken = userJWT['refresh_token'];

    DateTime expiredDate = DateTime.fromMillisecondsSinceEpoch(
        parsedAccessToken['exp'] * 1000,
        isUtc: true);
    if (expiredDate.compareTo(DateTime.now()) == -1) {
      // Token was expired

      var r = await RequestUtils.tryCatchRequest(
          null, refreshToken, [userRefreshToken]);

      if (r != null && r.statusCode == 200) {
        Map<String, String> tokens = {
          'token': jsonDecode(r.body)['token'],
          'refresh_token': jsonDecode(r.body)['refresh_token']
        };
        var storeStatus = await StorageUtils.saveJWT(
            'jwt', tokens['token'], tokens['refresh_token']);
        if (storeStatus) {
          accessToken = tokens['token'];
        } else {
          accessToken = '';
        }
      } else {
        accessToken = '';
      }
    }

    return accessToken;
  }

  static Map<String, dynamic> decode(token) {
    return JwtDecoder.decode(token);
  }

  static Future<Map<dynamic, dynamic>> get getJWT {
    return StorageUtils.userJWT;
  }
}

class StorageUtils {
  static Future<Map<dynamic, dynamic>> get userJWT async {
    var box = await Hive.openBox('jwt');
    var user = box.toMap();
    if (user == null) return null;
    return user;
  }

  static Future<dynamic> get(String boxName, String key) async {
    var box = await Hive.openBox(boxName);
    return box.get(key);
  }

  static Future<Map<dynamic, dynamic>> getBox(String boxName) async {
    var box = await Hive.openBox(boxName);
    return box.toMap();
  }

  static Future<bool> save(String boxName, String key, dynamic value) async {
    var box = await Hive.openBox(boxName);

    try {
      await box.put(key, value);
    } catch (e) {
      if (globals.debugMode) print(e);
      return false;
    }

    return true;
  }

  static Future<bool> saves(
      String boxName, Map<dynamic, dynamic> entries) async {
    var box = await Hive.openBox(boxName);

    try {
      await box.putAll(entries);
    } catch (e) {
      return false;
    }

    return true;
  }

  static Future<bool> saveJWT(
      String boxName, String token, String refreshToken) async {
    var box = await Hive.openBox(boxName);

    try {
      await box.put('token', token);
      await box.put('refresh_token', refreshToken);
    } catch (e) {
      return false;
    }

    return true;
  }

  static Future<bool> delete(String boxName, String key) async {
    var box = await Hive.openBox(boxName);

    try {
      await box.delete(key);
    } catch (e) {
      return false;
    }
    return true;
  }

  static Future<bool> deleteBox(String boxName) async {
    try {
      await Hive.deleteBoxFromDisk(boxName);
    } catch (e) {
      return false;
    }
    return true;
  }
}

class AlertUtils {
  /// Print alert box with custom title and message
  static Future<void> showMyDialog(
      BuildContext c, String title, String message) async {
    return showDialog<void>(
      context: c,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(AppLocalizations.of(context).close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> showMyDialogAndRestart(BuildContext c) async {
    return showDialog<void>(
      context: c,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context).information),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(AppLocalizations.of(context).app_reboot_required),
                Text(AppLocalizations.of(context).reboot_now),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(AppLocalizations.of(context).no),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(AppLocalizations.of(context).yes),
              onPressed: () async {
                await SystemChannels.platform
                    .invokeMethod<void>('SystemNavigator.pop', true);
              },
            ),
          ],
        );
      },
    );
  }
}

class LanguageUtils {
  static Map<String, String> getLanguages(BuildContext context) {
    Map<String, String> languages = {};

    ConstantLanguage.languages.forEach((element) {
      switch (element) {
        case 'en':
          languages['en'] = AppLocalizations.of(context).english;
          break;
        case 'fr':
          languages['fr'] = AppLocalizations.of(context).french;
          break;
        default:
      }
    });

    return languages;
  }

  static String getValueAt(Map<String, String> languages, int index) {
    return languages.values.elementAt(index);
  }

  static String getKeyAt(Map<String, String> languages, int index) {
    return languages.keys.elementAt(index);
  }

  static String getKeyValue(Map<String, String> languages, String key) {
    return languages.values.elementAt(languages.keys.toList().indexOf(key));
  }

  static String getValueKey(Map<String, String> languages, String value) {
    return languages.keys.elementAt(languages.values.toList().indexOf(value));
  }
}
