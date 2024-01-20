import 'dart:convert';
import 'package:http/http.dart';
import 'package:madaresco/Util/SharedPrefernce.dart';
import 'package:madaresco/core/Network/network.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/features/ExamResult/data/models/exam_results_model.dart';
import 'package:madaresco/features/Login/data/remote/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ExamResultsRemoteDataSource {
  ///Throws [ServerException]
  Future<ExamResultsModel> getExamResults();
  Future<String> getExamResultsPdf();
}

class ExamResultsRemoteDataSourceImpl implements ExamResultsRemoteDataSource {
  Network _network;

  ExamResultsRemoteDataSourceImpl({
    required Network network,
  }) : _network = network;

  @override
  Future<ExamResultsModel> getExamResults() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cToken = prefs.getString("Ctoken");
    LoginModel? model = await SharedPreference.getLoginModel();
    Response response = await _network.getData(
        url: 'results',
        token: cToken ?? model!.token!,
        isPrint: false,
        removeNotificationType: "App\\Notifications\\ResultCreatedNotification",
        removeNotifications: true,
        );
    if (response.statusCode == 200) {
      return ExamResultsModel.fromJson(jsonDecode(response.body));
    } else {
      throw (ServerException());
    }
  }

  @override
  Future<String> getExamResultsPdf() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int cStudentId = await SharedPreference.getStudentId();
    String? cToken = prefs.getString("Ctoken");
    LoginModel? model = await SharedPreference.getLoginModel();
    Response response = await _network.getData(
      url: 'print_results/${cStudentId != 0 ? cStudentId : model!.data!.id}',
      token: cToken ?? model!.token!,
      isPrint: false,
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      throw (ServerException());
    }
  }
}
