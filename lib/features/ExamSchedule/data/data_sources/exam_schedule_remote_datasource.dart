import 'dart:convert';
import 'package:http/http.dart';
import 'package:madaresco/Util/SharedPrefernce.dart';
import 'package:madaresco/core/Network/network.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/features/ExamSchedule/data/models/exam_schedule_model.dart';
import 'package:madaresco/features/Login/data/remote/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ExamScheduleRemoteDataSource {
  /// Throws [ServerException]
  Future<ExamScheduleModel> getExam(int id);
}

class ExamScheduleRemoteDataSourceImpl implements ExamScheduleRemoteDataSource {
  Network _network;

  ExamScheduleRemoteDataSourceImpl({
    required Network network,
  }) : _network = network;

  @override
  Future<ExamScheduleModel> getExam(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cToken = prefs.getString("Ctoken");
    LoginModel? model = await SharedPreference.getLoginModel();
    Response response = await _network.getData(
        url: 'exams/$id', token: cToken ?? model!.token!);
    if (response.statusCode == 200) {
      return ExamScheduleModel.fromJson(jsonDecode(response.body));
    } else {
      throw (ServerException());
    }
  }
}
