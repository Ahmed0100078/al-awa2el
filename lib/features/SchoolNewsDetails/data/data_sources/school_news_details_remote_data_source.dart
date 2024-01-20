import 'dart:convert';
import 'package:http/http.dart';
import 'package:madaresco/Util/SharedPrefernce.dart';
import 'package:madaresco/core/Network/network.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/features/Login/data/remote/models/login_model.dart';
import 'package:madaresco/features/SchoolNewsDetails/data/models/school_news_details_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SchoolNewsDetailsRemoteDataSource {
  /// Throws [ServerException]
  Future<SchoolNewsDetailsModel> getSchoolNewsDetails(int id);
}

class SchoolNewsDetailsRemoteDataSourceImpl
    implements SchoolNewsDetailsRemoteDataSource {
  Network _network;

  SchoolNewsDetailsRemoteDataSourceImpl({
    required Network network,
  }) : _network = network;

  @override
  Future<SchoolNewsDetailsModel> getSchoolNewsDetails(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cToken = prefs.getString("Ctoken");
    LoginModel? model = await SharedPreference.getLoginModel();
    Response response = await _network.getData(
        url: 'news/$id',
        token: cToken ?? model!.token!,
        removeNotificationType: "App\\Notifications\\NewsCreatedNotification",
        removeNotifications: true);
    if (response.statusCode == 200) {
      return SchoolNewsDetailsModel.fromJson(jsonDecode(response.body));
    } else {
      throw (ServerException());
    }
  }
}
