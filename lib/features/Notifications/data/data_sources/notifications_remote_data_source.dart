import 'dart:convert';
import 'package:http/http.dart';
import 'package:madaresco/Util/SharedPrefernce.dart';
import 'package:madaresco/core/Network/network.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/features/Login/data/remote/models/login_model.dart';
import 'package:madaresco/features/Notifications/data/models/notifications_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class NotificationsRemoteDataSource {
  /// Throws[ServerException]
  Future<NotificationsModel> getNotifications();
}

class NotificationsRemoteDataSourceImpl
    implements NotificationsRemoteDataSource {
  Network _network;

  NotificationsRemoteDataSourceImpl({
    required Network network,
  }) : _network = network;

  @override
  Future<NotificationsModel> getNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cToken = prefs.getString("Ctoken");
    LoginModel? model = await SharedPreference.getLoginModel();
    Response response = await _network.getData(
        url: 'notifications',
        token: cToken ?? model!.token!,
        isPrint: false,
        removeAllNotifications: true,
        removeNotifications: true);
    if (response.statusCode == 200) {
      return NotificationsModel.fromJson(jsonDecode(response.body));
    } else {
      throw (ServerException());
    }
  }
}
