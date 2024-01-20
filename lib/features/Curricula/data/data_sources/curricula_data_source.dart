import 'dart:convert';
import 'package:http/http.dart';
import 'package:madaresco/Util/SharedPrefernce.dart';
import 'package:madaresco/core/Network/network.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/features/Curricula/data/models/curricula_grades_model.dart';
import 'package:madaresco/features/Curricula/data/models/curricula_model.dart';
import 'package:madaresco/features/Curricula/data/models/curricula_stages_model.dart';
import 'package:madaresco/features/Curricula/data/models/curricula_subjects_model.dart';
import 'package:madaresco/features/Login/data/remote/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CurriculaRemoteDataSource {
  /// Throws [ServerException]
  Future<CurriculaModel> getCurricula(
      [int stageId, int gradeId, int subjectId, String term, int page = 1]);
  Future<CurriculaStagesModel> getStages();
  Future<CurriculaGradesModel> getGrades(int id);
  Future<CurriculaSubjectsModel> getSubjects(int id);
}

class CurriculaRemoteDataSourceImpl implements CurriculaRemoteDataSource {
  Network _network;

  CurriculaRemoteDataSourceImpl({
    required Network network,
  }) : _network = network;

  @override
  Future<CurriculaModel> getCurricula(
      [int? stageId,
      int? gradeId,
      int? subjectId,
      String? term,
      int page = 1]) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cToken = prefs.getString("Ctoken");
    LoginModel? model = await SharedPreference.getLoginModel();
    Response response = await _network.getData(
        url:
            'books?term=${term ?? ''}&grade_id=${gradeId?.toString() ?? ''}&stage_id=${stageId?.toString() ?? ''}&subject_id=${subjectId?.toString() ?? ''}',
        token: cToken ?? model!.token!);
    if (response.statusCode == 200) {
      return CurriculaModel.map(jsonDecode(response.body));
    } else {
      throw (ServerException());
    }
  }

  @override
  Future<CurriculaGradesModel> getGrades(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cToken = prefs.getString("Ctoken");
    LoginModel? model = await SharedPreference.getLoginModel();
    Response response = await _network.getData(
        url: 'stages/$id', token: cToken ?? model!.token!);
    if (response.statusCode == 200) {
      return CurriculaGradesModel.fromJson(jsonDecode(response.body));
    } else {
      throw (ServerException());
    }
  }

  @override
  Future<CurriculaStagesModel> getStages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cToken = prefs.getString("Ctoken");
    LoginModel? model = await SharedPreference.getLoginModel();
    Response response = await _network.getData(
        url: 'stages/created_by_admin?without_pagination=1',
        token: cToken ?? model!.token!);
    if (response.statusCode == 200) {
      return CurriculaStagesModel.fromJson(jsonDecode(response.body));
    } else {
      throw (ServerException());
    }
  }

  @override
  Future<CurriculaSubjectsModel> getSubjects(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cToken = prefs.getString("Ctoken");
    LoginModel? model = await SharedPreference.getLoginModel();
    Response response = await _network.getData(
        url: 'subjects?grade_id=600&without_pagination=1',
        token: cToken ?? model!.token!);
    if (response.statusCode == 200) {
      return CurriculaSubjectsModel.fromJson(jsonDecode(response.body));
    } else {
      throw (ServerException());
    }
  }
}
