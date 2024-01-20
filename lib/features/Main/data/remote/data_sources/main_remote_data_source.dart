import 'dart:convert';
import 'package:http/http.dart';
import 'package:madaresco/Util/SharedPrefernce.dart';
import 'package:madaresco/core/Network/network.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/features/Login/data/remote/models/login_model.dart';
import 'package:madaresco/features/Main/data/remote/models/MainNotificationsModel.dart';
import 'package:madaresco/features/Main/data/remote/models/StudentModel.dart';
import 'package:madaresco/features/Notifications/data/models/notifications_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class MainRemoteDataSource {
  /// Throws[ServerException]
  Future<StudentModel> getStudentInfo();
  Future<MainNotificationsModel> getMainNotifications();
  Future<NotificationsModel> getNotifications();
}

class MainRemoteDataSourceImpl implements MainRemoteDataSource {
  Network _network;

  MainRemoteDataSourceImpl({
    required Network network,
  }) : _network = network;

  @override
  Future<StudentModel> getStudentInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cToken = prefs.getString("Ctoken");
    LoginModel? model = await SharedPreference.getLoginModel();
    Response response =
        await _network.getData(url: 'me', token: cToken ?? model!.token!);
    print('response.statusCode=${response.statusCode}');

    if (response.statusCode == 200) {
      return StudentModel.fromJson(jsonDecode(response.body));
    } else {
      throw (ServerException());
    }
  }

  @override
  Future<MainNotificationsModel> getMainNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cToken = prefs.getString("Ctoken");
    LoginModel? model = await SharedPreference.getLoginModel();
    Response response = await _network.getData(
        url: 'notifications/flags/get', token: cToken ?? model!.token!);
    if (response.statusCode == 200) {
      return MainNotificationsModel.fromJson(jsonDecode(response.body));
    } else {
      throw (ServerException());
    }
  }

  @override
  Future<NotificationsModel> getNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cToken = prefs.getString("Ctoken");
    LoginModel? model = await SharedPreference.getLoginModel();
    Response response = await _network.getData(
      url: 'notifications',
      token: cToken ?? model!.token!,
      isPrint: false,
    );
    if (response.statusCode == 200) {
      return NotificationsModel.fromJson(jsonDecode(response.body));
    } else {
      throw (ServerException());
    }
  }
}
