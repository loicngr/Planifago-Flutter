library planifago.globals;

import 'api/types/user.dart';

Map<String, String> userTokens = {
  'token': null,
  'refresh_token': null
};

bool userLoginProcess = false;

User userData;