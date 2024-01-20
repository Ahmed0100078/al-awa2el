import 'dart:convert';
import 'package:http/http.dart';
import 'package:madaresco/Util/SharedPrefernce.dart';
import 'package:madaresco/core/Network/network.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/features/Login/data/remote/models/login_model.dart';
import 'package:madaresco/features/Main/data/remote/models/MainNotificationsModel.dart';
import 'package:madaresco/features/Supervisor/data/remote/models/Supervisor_model.dart';

abstract class SupervisorRemoteDataSource {
  /// Throws[ServerException]
  Future<SupervisorModel> getSupervisorInfo();
  Future<MainNotificationsModel> getMainNotifications();
}

class SupervisorRemoteDataSourceImpl implements SupervisorRemoteDataSource {
  Network _network;

  SupervisorRemoteDataSourceImpl({
    required Network network,
  }) : _network = network;

  @override
  Future<SupervisorModel> getSupervisorInfo() async {
    LoginModel? model = await SharedPreference.getLoginModel();
    Response response = await _network.getData(url: 'me', token: model!.token);
    if (response.statusCode == 200) {
      return SupervisorModel.fromJson(jsonDecode(response.body));
    } else {
      throw (ServerException());
    }
  }

  @override
  Future<MainNotificationsModel> getMainNotifications() async {
    LoginModel? model = await SharedPreference.getLoginModel();
    Response response = await _network.getData(
        url: 'notifications/flags/get', token: model!.token!);
    if (response.statusCode == 200) {
      return MainNotificationsModel.fromJson(jsonDecode(response.body));
    } else {
      throw (ServerException());
    }
  }
}
