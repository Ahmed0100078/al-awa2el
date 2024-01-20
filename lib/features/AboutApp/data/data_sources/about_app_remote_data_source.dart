import 'dart:convert';
import 'package:http/http.dart';
import 'package:madaresco/Util/SharedPrefernce.dart';
import 'package:madaresco/core/Network/network.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/features/AboutApp/data/models/about_app_model.dart';
import 'package:madaresco/features/Login/data/remote/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AboutAppRemoteDataSource {
  ///Throws [ServerException]
  Future<AboutAppModel> getAboutApp();
}

class AboutAppRemoteDataSourceImpl implements AboutAppRemoteDataSource {
  Network _network;

  AboutAppRemoteDataSourceImpl({
    required Network network,
  }) : _network = network;

  @override
  Future<AboutAppModel> getAboutApp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cToken = prefs.getString("Ctoken");
    LoginModel? model = await SharedPreference.getLoginModel();
    Response response =
        await _network.getData(url: 'settings', token: cToken ?? model!.token!);
    print(response.body);
    if (response.statusCode == 200) {
      return AboutAppModel.fromJson(jsonDecode(response.body));
    } else {
      throw (ServerException());
    }
  }
}
