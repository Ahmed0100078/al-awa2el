import 'dart:convert';
import 'package:http/http.dart';
import 'package:madaresco/Util/SharedPrefernce.dart';
import 'package:madaresco/core/Network/network.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/features/Login/data/remote/models/login_model.dart';
import 'package:madaresco/features/Schedule/data/models/schedule_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ScheduleRemoteDataSource {
  /// Throws [ServerException]
  Future<ScheduleModel> getSchedule(int day);
}

class ScheduleRemoteDataSourceImpl implements ScheduleRemoteDataSource {
  Network _network;

  ScheduleRemoteDataSourceImpl({
    required Network network,
  }) : _network = network;

  @override
  Future<ScheduleModel> getSchedule(int day) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cToken = prefs.getString("Ctoken");
    LoginModel? model = await SharedPreference.getLoginModel();
    Response response = await _network.getData(
        url: 'schedules?day=$day',
        token: cToken ?? model!.token!,
        removeNotifications: true,
        removeNotificationType:
            "App\\Notifications\\ScheduleCreatedNotification");
    if (response.statusCode == 200) {
  
      return ScheduleModel.fromJson(jsonDecode(response.body));
    } else {
      throw (ServerException());
    }
  }
}
