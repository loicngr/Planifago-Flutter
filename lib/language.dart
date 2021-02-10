import 'package:flutter/cupertino.dart';
import 'package:planifago/utils/utils.dart';

class AppLanguage extends ChangeNotifier {
  Locale _appLocale = Locale('en');

  Locale get appLocal => _appLocale ?? Locale('en');

  fetchLocale() async {
    var appDefaultLanguage = await StorageUtils.get('settings', 'language');
    if (appDefaultLanguage == null) {
      _appLocale = Locale('en');
      return Null;
    }
    _appLocale = Locale(appDefaultLanguage);
    return Null;
  }

  void changeLanguage(Locale type) async {
    if (_appLocale == type) {
      return;
    }
    if (type == Locale("fr")) {
      _appLocale = Locale("fr");
      await StorageUtils.save('settings', 'language', 'fr');
    } else {
      _appLocale = Locale("en");
      await StorageUtils.save('settings', 'language', 'en');
    }
    notifyListeners();
  }
}
