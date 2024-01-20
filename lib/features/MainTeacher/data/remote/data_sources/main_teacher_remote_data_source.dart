import 'dart:convert';
import 'package:http/http.dart';
import 'package:madaresco/Util/SharedPrefernce.dart';
import 'package:madaresco/core/Network/network.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/features/Login/data/remote/models/login_model.dart';
import 'package:madaresco/features/Main/data/remote/models/MainNotificationsModel.dart';
import 'package:madaresco/features/MainTeacher/data/remote/models/teacher_model.dart';

abstract class MainTeacherRemoteDataSource {
  /// Throws[ServerException]
  Future<TeacherModel> getTeacherInfo();
  Future<MainNotificationsModel> getMainNotifications();
}

class MainTeacherRemoteDataSourceImpl implements MainTeacherRemoteDataSource {
  Network _network;

  MainTeacherRemoteDataSourceImpl({
    required Network network,
  }) : _network = network;

  @override
  Future<TeacherModel> getTeacherInfo() async {
    LoginModel? model = await SharedPreference.getLoginModel();
    Response response = await _network.getData(url: 'me', token: model!.token!);
    if (response.statusCode == 200) {
      return TeacherModel.fromJson(jsonDecode(response.body));
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
