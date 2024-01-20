import 'dart:convert';
import 'package:http/http.dart';
import 'package:madaresco/Util/SharedPrefernce.dart';
import 'package:madaresco/core/Network/network.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/features/AllTeacher/data/models/all_teachers_model.dart';
import 'package:madaresco/features/Login/data/remote/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AllTeachersRemoteDataSource {
  /// Throws [ServerException]
  Future<AllTeachersModel> getAllTeachers([int page = 1]);
}

class AllTeachersRemoteDataSourceImpl implements AllTeachersRemoteDataSource {
  Network _network;

  AllTeachersRemoteDataSourceImpl({
    required Network network,
  }) : _network = network;

  @override
  Future<AllTeachersModel> getAllTeachers([int page = 1]) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cToken = prefs.getString("Ctoken");
    LoginModel? model = await SharedPreference.getLoginModel();
    Response response = await _network.getData(
        url: 'teachers?page=$page', token: cToken ?? model!.token!);
    if (response.statusCode == 200) {
      return AllTeachersModel.fromJson(jsonDecode(response.body));
    } else {
      throw (ServerException());
    }
  }
}
