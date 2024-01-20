import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart';
import 'package:madaresco/Util/SharedPrefernce.dart';
import 'package:madaresco/core/Network/network.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/features/Login/data/remote/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LoginRemoteDataSource {
  /// Throws a [ServerException] for all error codes.
  Future<LoginModel> login(String userCode, String password, String schoolCode,
      String email, String type);

  Future<bool> deleteStudentAccount();
  Future<bool> deleteTeacherAccount();
  Future<bool> deleteSupervisorAccount();
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final Network network;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  //TODO: Add Notification Token To Use case
  LoginRemoteDataSourceImpl({required this.network});

  String? notificationToken;

  @override
  Future<LoginModel> login(String userCode, String password, String schoolCode,
      String email, String type) async {
    notificationToken = await _firebaseMessaging.getToken();
    SharedPreference.setNotificationToken(notificationToken!);
    var map = {
      'user_code': userCode,
      'password': password,
      'school_code': schoolCode,
      'fcm-token': notificationToken,
      'email': email,
      'type': type
    };
    map.removeWhere((key, value) =>
        key.isEmpty || value == null || value == '' || key == '');
    Response response = await network.postData(
        url: 'auth/login', body: map, handleError: false, showError: true);
    if (response.statusCode == 200) {
      return LoginModel.fromJson(jsonDecode(response.body));
    } else {
      throw (ServerException());
    }
  }

  @override
  Future<bool> deleteStudentAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cToken = prefs.getString("Ctoken");
    LoginModel? model = await SharedPreference.getLoginModel();
    print('ID >>>> ${model!.data!.id}');
    print('TOKEN >>>> $cToken ');
    Response response = await network.deleteData(
        url: 'students/${model.data!.id}', token: cToken ?? model.token!);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw (ServerException());
    }
  }

  @override
  Future<bool> deleteTeacherAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cToken = prefs.getString("Ctoken");
    LoginModel? model = await SharedPreference.getLoginModel();
    Response response = await network.deleteData(
        url: 'teachers/${model!.data!.id}', token: cToken ?? model.token!);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw (ServerException());
    }
  }

  @override
  Future<bool> deleteSupervisorAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cToken = prefs.getString("Ctoken");
    LoginModel? model = await SharedPreference.getLoginModel();
    Response response = await network.deleteData(
        url: 'supervisors/${model!.data!.id}', token: cToken ?? model.token!);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw (ServerException());
    }
  }
}
