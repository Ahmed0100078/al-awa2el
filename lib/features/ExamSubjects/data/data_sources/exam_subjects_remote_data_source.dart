import 'dart:convert';
import 'package:http/http.dart';
import 'package:madaresco/Util/SharedPrefernce.dart';
import 'package:madaresco/core/Network/network.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/features/ExamSubjects/data/models/exam_subjects_model.dart';
import 'package:madaresco/features/Login/data/remote/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ExamSubjectsRemoteDataSource {
  /// Throws [ServerException]
  Future<ExamSubjectsModel> getSubjects({int page = 1});
}

class ExamSubjectsRemoteDataSourceImpl implements ExamSubjectsRemoteDataSource {
  Network _network;

  ExamSubjectsRemoteDataSourceImpl({
    required Network network,
  }) : _network = network;

  @override
  Future<ExamSubjectsModel> getSubjects({int page = 1}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cToken = prefs.getString("Ctoken");
    LoginModel? model = await SharedPreference.getLoginModel();
    Response response = await _network.getData(
        url: 'exams?page=$page',
        token: cToken ?? model!.token!,
        removeNotifications: true,
        removeNotificationType: "App\\Notifications\\ExamCreatedNotification");
    if (response.statusCode == 200) {
      return ExamSubjectsModel.fromJson(jsonDecode(response.body));
    } else {
      throw (ServerException());
    }
  }
}
