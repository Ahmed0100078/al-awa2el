import 'dart:convert';
import 'package:http/http.dart';
import 'package:madaresco/Util/SharedPrefernce.dart';
import 'package:madaresco/core/Network/network.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/features/Annual/data/remote/models/annuals_model.dart';
import 'package:madaresco/features/Login/data/remote/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AnnualsRemoteDataSource {
  /// Throws [ServerException]
  Future<AnnualsModel> getAnnuals();
}

class AnnualsRemoteDataSourceImpl implements AnnualsRemoteDataSource {
  Network _network;

  AnnualsRemoteDataSourceImpl({
    required Network network,
  }) : _network = network;

  @override
  Future<AnnualsModel> getAnnuals() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cToken = prefs.getString("Ctoken");
    LoginModel? model = await SharedPreference.getLoginModel();
    Response response = await _network.getData(
        url: 'installments',
        token: cToken ?? model!.token!,
        removeNotificationType:
            "App\\Notifications\\InstallmentCreatedNotification",
        removeNotifications: true);
    if (response.statusCode == 200) {
      return AnnualsModel.fromJson(jsonDecode(response.body));
    } else {
      throw (ServerException());
    }
  }
}
