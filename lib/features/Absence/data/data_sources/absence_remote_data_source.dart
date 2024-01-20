import 'dart:convert';
import 'package:http/http.dart';
import 'package:madaresco/Util/SharedPrefernce.dart';
import 'package:madaresco/core/Network/network.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/features/Absence/data/models/absence_model.dart';
import 'package:madaresco/features/Login/data/remote/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AbsenceRemoteDataSource {
  /// Throws [ServerException]
  Future<AbsenceModel> getAbsence([String date]);
}

class AbsenceRemoteDataSourceImpl implements AbsenceRemoteDataSource {
  Network _network;

  AbsenceRemoteDataSourceImpl({
    required Network network,
  }) : _network = network;

  @override
  Future<AbsenceModel> getAbsence([String? date]) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cToken = prefs.getString("Ctoken");
    LoginModel? model = await SharedPreference.getLoginModel();
    String url = date != null ? 'searchAttendance?date=$date' : 'attendance';
    Response response = await _network.getData(
        url: url,
        token: cToken ?? model!.token!,
        removeNotifications: true,
        removeNotificationType:
            "App\\Notifications\\AttendanceCreatedNotification");
    if (response.statusCode == 200) {
      return AbsenceModel.fromJson(jsonDecode(response.body));
    } else {
      throw (ServerException());
    }
  }
}
