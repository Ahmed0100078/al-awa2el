import 'dart:convert';
import 'package:http/http.dart';
import 'package:madaresco/Util/SharedPrefernce.dart';
import 'package:madaresco/core/Network/network.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/features/LessonDetails/data/models/lesson_details_model.dart';
import 'package:madaresco/features/Login/data/remote/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class GetLessonDetailsRemoteDataSource {
  /// Throws [ServerException]
  Future<LessonDetailsModel> getLessonDetails(int lessonId);
}

class GetLessonDetailsRemoteDataSourceImpl
    implements GetLessonDetailsRemoteDataSource {
  Network _network;

  GetLessonDetailsRemoteDataSourceImpl({
    required Network network,
  }) : _network = network;

  @override
  Future<LessonDetailsModel> getLessonDetails(int lessonId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cToken = prefs.getString("Ctoken");
    LoginModel? model = await SharedPreference.getLoginModel();
    Response response = await _network.getData(
        url: 'lessons/$lessonId', token: cToken ?? model!.token!);
    if (response.statusCode == 200) {
      return LessonDetailsModel.fromJson(jsonDecode(response.body));
    } else {
      throw (ServerException());
    }
  }
}
