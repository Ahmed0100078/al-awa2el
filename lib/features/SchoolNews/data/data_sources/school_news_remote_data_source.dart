import 'dart:convert';
import 'package:http/http.dart';
import 'package:madaresco/Util/SharedPrefernce.dart';
import 'package:madaresco/core/Network/network.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/features/Login/data/remote/models/login_model.dart';
import 'package:madaresco/features/SchoolNews/data/models/school_news_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SchoolNewsRemoteDataSource {
  ///throws [ServerException]
  Future<SchoolNewsModel> getNews([int page = 1]);
}

class SchoolNewsRemoteDataSourceImpl implements SchoolNewsRemoteDataSource {
  Network _network;

  SchoolNewsRemoteDataSourceImpl({
    required Network network,
  }) : _network = network;

  @override
  Future<SchoolNewsModel> getNews([int page = 1]) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cToken = prefs.getString("Ctoken");
    LoginModel? model = await SharedPreference.getLoginModel();
    Response response = await _network.getData(
        url: 'news?page=$page', token: cToken ?? model!.token!);
    if (response.statusCode == 200) {
      return SchoolNewsModel.fromJson(jsonDecode(response.body));
    } else {
      throw (ServerException());
    }
  }
}
