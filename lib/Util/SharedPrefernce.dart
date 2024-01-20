import 'dart:convert';
import 'package:madaresco/features/Login/data/local/data_sources/login_local_datasource.dart';
import 'package:madaresco/features/Login/data/remote/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static Future<LoginModel?> getLoginModel() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var data = jsonDecode(pref.getString(CACHED_USER_DATA)!);
    LoginModel? model = data != null ? LoginModel.fromJson(data) : null;
    return model;
  }

  static void setLoginModel(LoginModel jsonModel) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String data = jsonEncode(jsonModel.toJson());
    await pref.setString(CACHED_USER_DATA, data);
  }

  static void updateLoginModel(LoginDatas logindata) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var data = jsonDecode(pref.getString(CACHED_USER_DATA)!);
    LoginModel? model = data != null ? LoginModel.fromJson(data) : null;
    model!.data = logindata;
    LoginModel newModel = model;
    await pref.setString(CACHED_USER_DATA, jsonEncode(newModel.toJson()));
  }

  static void setNotificationToken(String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('NOTIFICATIONTOKEN', token);
  }

  static Future<String?> getNotificationToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('NOTIFICATIONTOKEN');
  }

  static void setDeviceId(String id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('DeviceId', id);
  }

  static Future<String?> getDeviceId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('DeviceId');
  }

  static void setStudentId(int id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setInt('cStudentId', id);
  }

  static Future<int> getStudentId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt('cStudentId')??0;
  }

  static void clearSharedPrefrence() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.getKeys();
    for (String key in preferences.getKeys()) {
      if (key != "FirstTime") {
        preferences.remove(key);
      }
    }
  }

  static void setIsFirstTime(bool isFirstTime) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool('FirstTime', isFirstTime);
  }

  static Future<bool?> getIsFirstTime() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? data = pref.getBool('FirstTime');
    return data;
  }
}
