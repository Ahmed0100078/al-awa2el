import 'dart:convert';
import 'package:http/http.dart';
import 'package:madaresco/Util/SharedPrefernce.dart';
import 'package:madaresco/core/Network/network.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/features/GallaryDetails/data/models/gallary_details_model.dart';
import 'package:madaresco/features/Login/data/remote/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class GallaryDetailsRemoteDataSource {
  ///Throws [ServerException]
  Future<GallaryDetailsModel> getGallaryDetails(int id);
}

class GallaryDetailsRemoteDataSourceImpl
    implements GallaryDetailsRemoteDataSource {
  Network _network;

  GallaryDetailsRemoteDataSourceImpl({
    required Network network,
  }) : _network = network;

  @override
  Future<GallaryDetailsModel> getGallaryDetails(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cToken = prefs.getString("Ctoken");
    LoginModel? model = await SharedPreference.getLoginModel();
    Response response = await _network.getData(
        url: 'school_media/$id',
        token: cToken ?? model!.token!,
        removeNotificationType:
            "App\\Notifications\\SchoolMediaCreatedNotification",
        removeNotifications: true);
    if (response.statusCode == 200) {
      return GallaryDetailsModel.fromJson(jsonDecode(response.body));
    } else {
      throw (ServerException());
    }
  }
}
