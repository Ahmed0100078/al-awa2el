import 'dart:convert';
import 'package:http/http.dart';
import 'package:madaresco/Util/SharedPrefernce.dart';
import 'package:madaresco/core/Network/network.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/features/Login/data/remote/models/login_model.dart';
import 'package:madaresco/features/OnlineLessons/data/models/online_lessons_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class OnlineLessonsRemoteDataSource {
  /// Throws [ServerException]
  Future<OnlineLessonsModel> getOnlineLessons([int page = 1]);
}

class OnlineLessonsRemoteDataSourceImpl
    implements OnlineLessonsRemoteDataSource {
  final Network _network;

  const OnlineLessonsRemoteDataSourceImpl({
    required Network network,
  }) : _network = network;

  @override
  Future<OnlineLessonsModel> getOnlineLessons([int page = 1]) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cToken = prefs.getString("Ctoken");
    LoginModel? model = await SharedPreference.getLoginModel();
    Response response = await _network.getData(
        url: 'lessons?online=1&page=$page',
        token: cToken ?? model!.token!,
        removeNotifications: true,
        removeNotificationType:
            "App\\Notifications\\LessonCreatedNotification");
    if (response.statusCode == 200) {
      return OnlineLessonsModel.fromJson(jsonDecode(response.body));
    } else {
      throw (ServerException());
    }
  }
}
