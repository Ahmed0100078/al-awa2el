import 'dart:convert';
import 'package:madaresco/features/Login/data/remote/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LoginLocalDataSource {
  /// Throws [CacheException] if can't cache data.
  Future<void> saveUserData(LoginModel model);
}

const CACHED_USER_DATA = 'CACHED_USER_DATA';

class LoginLocalDataSourceImpl implements LoginLocalDataSource {
  SharedPreferences sharedPreferences;
  LoginLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> saveUserData(LoginModel model) async {
    await sharedPreferences.setString(
        CACHED_USER_DATA, jsonEncode(model.toJson()));
  }
}
