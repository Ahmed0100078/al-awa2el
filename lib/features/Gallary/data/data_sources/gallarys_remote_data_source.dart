import 'dart:convert';
import 'package:http/http.dart';
import 'package:madaresco/Util/SharedPrefernce.dart';
import 'package:madaresco/core/Network/network.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/features/Gallary/data/models/gallary_model.dart';
import 'package:madaresco/features/Login/data/remote/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class GallarysRemoteDataSource {
  ///Throws [ServerException]
  Future<GallaryModel> getGallarys([int page = 1]);
}

class GallarysRemoteDataSourceImpl implements GallarysRemoteDataSource {
  Network _network;

  GallarysRemoteDataSourceImpl({
    required Network network,
  }) : _network = network;

  @override
  Future<GallaryModel> getGallarys([int page = 1]) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cToken = prefs.getString("Ctoken");
    LoginModel? model = await SharedPreference.getLoginModel();
    Response response = await _network.getData(
        url: 'school_media', token: cToken ?? model!.token!, isPrint: false);
    if (response.statusCode == 200) {
      return GallaryModel.fromJson(jsonDecode(response.body));
    } else {
      throw (ServerException());
    }
  }
}
