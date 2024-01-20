import 'dart:convert';
import 'package:http/http.dart';
import 'package:madaresco/Util/SharedPrefernce.dart';
import 'package:madaresco/core/Network/network.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/features/Login/data/remote/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class StudentBehaviorRemoteDataSource {
  Future<LoginModel> getStudentBehavior();
}

class StudentBehaviorRemoteDataSourceImpl
    implements StudentBehaviorRemoteDataSource {
  final Network _network;

  const StudentBehaviorRemoteDataSourceImpl({
    required Network network,
  }) : _network = network;

  @override
  Future<LoginModel> getStudentBehavior() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cToken = prefs.getString("Ctoken");
    LoginModel? model = await SharedPreference.getLoginModel();
    Response response = await _network.getData(
        removeNotifications: true,
        removeNotificationType:
            "App\\Notifications\\WarningCreatedNotification",
        url: 'me',
        token: cToken ?? model!.token!);
    if (response.statusCode == 200) {
      return LoginModel.fromJson(jsonDecode(response.body));
    } else {
      throw (ServerException());
    }
  }
}
