import 'dart:convert';
import 'package:http/http.dart';
import 'package:madaresco/Util/SharedPrefernce.dart';
import 'package:madaresco/core/Network/network.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/features/AllLessons/data/models/all_lessons_model.dart';
import 'package:madaresco/features/Login/data/remote/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AllLessonsRemoteDataSource {
  /// Throws [ServerException]
  Future<AllLessonsModel> getLessons(int id, [int page = 1]);
}

class AllLessonsRemoteDataSourceImpl implements AllLessonsRemoteDataSource {
  Network _network;

  AllLessonsRemoteDataSourceImpl({
    required Network network,
  }) : _network = network;

  @override
  Future<AllLessonsModel> getLessons(int id, [int page = 1]) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cToken = prefs.getString("Ctoken");
    LoginModel? model = await SharedPreference.getLoginModel();
    Response response = await _network.getData(
        url: 'lessons?subject_id=$id&page=$page',
        isPrint: false,
        token: cToken ?? model!.token!);
    if (response.statusCode == 200) {
      print(response.body);
      return AllLessonsModel.fromJson(jsonDecode(response.body));
    } else {
      throw (ServerException());
    }
  }
}
