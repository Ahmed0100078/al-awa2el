import 'dart:convert';
import 'package:http/http.dart';
import 'package:madaresco/Util/SharedPrefernce.dart';
import 'package:madaresco/core/Network/network.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/features/Login/data/remote/models/login_model.dart';
import 'package:madaresco/features/MadarescoLessons/data/models/madaresco_lessons_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class MadarescoLessonsRemoteDataSource {
  /// Throws [ServerException]
  Future<MadarescoLessonsModel> getMadarescoLessons(
      [int stageId, int gradeId, String term, int page = 1]);
}

class MadarescoLessonsRemoteDataSourceImpl
    implements MadarescoLessonsRemoteDataSource {
  Network _network;

  MadarescoLessonsRemoteDataSourceImpl({
    required Network network,
  }) : _network = network;

  @override
  Future<MadarescoLessonsModel> getMadarescoLessons(
      [int? stageId, int? gradeId, String? term, int page = 1]) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cToken = prefs.getString("Ctoken");
    LoginModel? model = await SharedPreference.getLoginModel();
    Response response = await _network.getData(
        url:
            'lessons?created_by_admin=1&term=${term ?? ''}&grade_id=${gradeId?.toString() ?? ''}&stage_id=${stageId?.toString() ?? ''}',
        token: cToken ?? model!.token!);
    if (response.statusCode == 200) {
      return MadarescoLessonsModel.fromJson(jsonDecode(response.body));
    } else {
      throw (ServerException());
    }
  }
}
