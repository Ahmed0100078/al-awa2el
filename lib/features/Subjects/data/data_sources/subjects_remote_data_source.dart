import 'dart:convert';
import 'package:http/http.dart';
import 'package:madaresco/Util/SharedPrefernce.dart';
import 'package:madaresco/core/Network/network.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/features/Login/data/remote/models/login_model.dart';
import 'package:madaresco/features/Subjects/data/models/subject_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SubjectsRemoteDataSource {
  ///Throws [ServerException]
  Future<SubjectModel> getSubjects();
}

class SubjectsRemoteDataSourceImpl implements SubjectsRemoteDataSource {
  Network _network;

  SubjectsRemoteDataSourceImpl({
    required Network network,
  }) : _network = network;

  @override
  Future<SubjectModel> getSubjects() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cToken = prefs.getString("Ctoken");
    LoginModel? model = await SharedPreference.getLoginModel();
    Response response = await _network.getData(
        url: model!.type == "teacher" ? "select/new/subjects" : 'subjects',
        removeNotifications: true,
        removeNotificationType: "App\\Notifications\\LessonCreatedNotification",
        token: cToken ?? model.token!);

    if (response.statusCode == 200) {
      print('subjects. ${response.body}');
      return SubjectModel.fromJson(jsonDecode(response.body));
    } else {
      throw (ServerException());
    }
  }
}
