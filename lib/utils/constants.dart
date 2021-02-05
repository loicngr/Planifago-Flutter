import 'package:flutter_dotenv/flutter_dotenv.dart';

class ConstantColors {
  static const blue = 0xff465EFE;
  static const gray = 0xffCBCFD7;
  static const light_gray = 0xffF0F0F0;
  static const dark_gray = 0xffa0a1a3;
  static const saumon = 0xffF9766B;
  static const green = 0xff20BA49;
  static const purple = 0xff8852FF;
  static const black = 0xff010101;
  static const white = 0xffFBFBFB;
}

class ConstantSize {
  static const landingButtonWidth = 300.00;
  static const landingButtonHeight = 60.00;
  static const landingLogoHeight = 70.00;
  static const landingButtonsPaddingHeight = 30.00;

  static const landingLoginButtonHeight = 50.00;
}

class ConstantApi {
  static final devApiIp = env['API_LOCAL_IP'] ?? '127.0.0.1';
  static final devApiPort = '8000';
  static final devApiProto = 'http';
  static final devApiAddress =
      devApiProto + '://' + devApiIp + ':' + devApiPort;
}

class ConstantLanguage {
  static final languages = ["en", "fr"];
}
