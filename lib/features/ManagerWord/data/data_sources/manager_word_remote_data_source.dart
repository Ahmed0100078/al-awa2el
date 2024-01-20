import 'dart:convert';
import 'package:http/http.dart';
import 'package:madaresco/Util/SharedPrefernce.dart';
import 'package:madaresco/core/Network/network.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/features/Login/data/remote/models/login_model.dart';
import 'package:madaresco/features/ManagerWord/data/models/manager_word_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ManagerWordRemoteDataSource {
  ///Throws [ServerException]
  Future<ManagerWordModel> getManagerWord();
}

class ManagerWordRemoteDataSourceImpl implements ManagerWordRemoteDataSource {
  Network _network;

  ManagerWordRemoteDataSourceImpl({
    required Network network,
  }) : _network = network;

  @override
  Future<ManagerWordModel> getManagerWord() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cToken = prefs.getString("Ctoken");
    LoginModel? model = await SharedPreference.getLoginModel();
    Response response = await _network.getData(
        url: 'admin_word',
        token: cToken ?? model!.token!,
        removeNotifications: true,
        removeNotificationType:
            "App\\Notifications\\AdminWordUpdatedNotification");
    if (response.statusCode == 200) {
      try {
        return ManagerWordModel.fromJson(jsonDecode(response.body));
      } catch (e) {
        throw (ServerException());
      }
    } else {
      throw (ServerException());
    }
  }
}
