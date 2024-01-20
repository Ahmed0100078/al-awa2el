import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class



AppLanguage extends ChangeNotifier {
  Locale _appLocale = Locale('ar');

  Locale get appLocal => _appLocale;
  Future<void> fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null) {
      _appLocale = Locale('ar');
      return null;
    }
    _appLocale = Locale(prefs.getString('language_code')!);
    return null;
  }


  void changeLanguage(Locale type) async {
    var prefs = await SharedPreferences.getInstance();
    if (_appLocale == type) {
      return;
    }
    if (type == Locale("ar")) {
      _appLocale = Locale("ar");
      await prefs.setString('language_code', 'ar');
      await prefs.setString('countryCode', '');
    } else if (type == Locale("ku")) {
      _appLocale = Locale("ku");
      await prefs.setString('language_code', 'ku');
      await prefs.setString('countryCode', '');
    } else {
      _appLocale = Locale("en");
      await prefs.setString('language_code', 'en');
      await prefs.setString('countryCode', 'US');
    }
    notifyListeners();
  }
}
