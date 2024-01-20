import 'dart:convert';
import 'package:http/http.dart';
import 'package:madaresco/Util/SharedPrefernce.dart';
import 'package:madaresco/core/Network/network.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/features/CurriculaDetails/data/models/curricula_details_model.dart';
import 'package:madaresco/features/Login/data/remote/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CurriculaDetailsRemoteDataSource {
  /// Throws [ServerException]
  Future<CurriculaDetailsModel> getCurriculaDetails(int id);
}

class CurriculaDetailsRemoteDataSourceImpl
    implements CurriculaDetailsRemoteDataSource {
  final Network _network;

  const CurriculaDetailsRemoteDataSourceImpl({
    required Network network,
  }) : _network = network;

  @override
  Future<CurriculaDetailsModel> getCurriculaDetails(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cToken = prefs.getString("Ctoken");
    LoginModel? model = await SharedPreference.getLoginModel();
    Response response = await _network.getData(
        url: 'books/$id', token: cToken ?? model!.token!);
    if (response.statusCode == 200) {
      return CurriculaDetailsModel.fromJson(jsonDecode(response.body));
    } else {
      throw (ServerException());
    }
  }
}
