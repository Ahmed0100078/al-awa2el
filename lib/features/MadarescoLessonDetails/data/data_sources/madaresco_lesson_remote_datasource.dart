import 'dart:convert';
import 'package:http/http.dart';
import 'package:madaresco/Util/SharedPrefernce.dart';
import 'package:madaresco/core/Network/network.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/features/Login/data/remote/models/login_model.dart';
import 'package:madaresco/features/MadarescoLessonDetails/data/models/madaresco_lesson_details_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class MadarescoLessonDetailsRemoteDataSource {
  /// Throws[ServerException]
  Future<MadarescoLessonDetailsModel> getLessonDetails(int id);
}

class MadarescoLessonDetailsRemoteDataSourceImpl
    implements MadarescoLessonDetailsRemoteDataSource {
  final Network _network;

  const MadarescoLessonDetailsRemoteDataSourceImpl({
    required Network network,
  }) : _network = network;

  @override
  Future<MadarescoLessonDetailsModel> getLessonDetails(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cToken = prefs.getString("Ctoken");
    LoginModel? model = await SharedPreference.getLoginModel();
    Response response = await _network.getData(
        url: 'lessons/$id', token: cToken ?? model!.token!);
    if (response.statusCode == 200) {
      return MadarescoLessonDetailsModel.fromJson(jsonDecode(response.body));
    } else {
      throw (ServerException());
    }
  }
}
