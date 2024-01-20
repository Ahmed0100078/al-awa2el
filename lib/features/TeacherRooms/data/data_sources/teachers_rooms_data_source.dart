import 'dart:convert';
import 'package:http/http.dart';
import 'package:madaresco/Util/SharedPrefernce.dart';
import 'package:madaresco/core/Network/network.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/features/Login/data/remote/models/login_model.dart';
import 'package:madaresco/features/TeacherRooms/data/models/Filterd%20studentsModel.dart';
import 'package:madaresco/features/TeacherRooms/data/models/GradesListModel.dart';
import 'package:madaresco/features/TeacherRooms/data/models/SectionsListModel.dart';
import 'package:madaresco/features/TeacherRooms/data/models/teachers_rooms_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class TeachersRoomsRemoteDataSource {
  /// Throws [ServerException]
  Future<TeachersRoomsModel> getTeachersRooms([int page = 1]);
  Future<FilteredStudentsModels> getFilterdStudents(int section, int grade);
  Future<GradesListModel> getGrades();
  Future<SectionsListModel> getSections();
}

class TeachersRoomsRemoteDataSourceImpl
    implements TeachersRoomsRemoteDataSource {
  Network _network;

  TeachersRoomsRemoteDataSourceImpl({
    required Network network,
  }) : _network = network;

  @override
  Future<TeachersRoomsModel> getTeachersRooms([int page = 1]) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cToken = prefs.getString("Ctoken");
    LoginModel? model = await SharedPreference.getLoginModel();
    Response response = await _network.getData(
        url: 'chat/rooms?page=$page',
        //url: 'getStudents?grade_id=630&section_id=856',
        token: cToken ?? model!.token!);
    if (response.statusCode == 200) {
      return TeachersRoomsModel.fromJson(jsonDecode(response.body));
    } else {
      throw (ServerException());
    }
  }

  String getFilterUrl(int? section, int? grade) {
    if (section != null && grade != null) {
      return 'getStudents?grade_id=$grade&section_id=$section';
    } else if (section == null) {
      return 'getStudents?grade_id=$grade';
    } else if (grade == null) {
      return 'getStudents?section_id=$section';
    } else
      return 'getStudents';
  }

  @override
  Future<FilteredStudentsModels> getFilterdStudents(
      int section, int grade) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cToken = prefs.getString("Ctoken");
    LoginModel? model = await SharedPreference.getLoginModel();
    Response response = await _network.getData(
        url: getFilterUrl(section, grade), token: cToken ?? model!.token!);
    if (response.statusCode == 200) {
      return FilteredStudentsModels.fromJson(jsonDecode(response.body));
    } else {
      throw (ServerException());
    }
  }

  @override
  Future<GradesListModel> getGrades() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cToken = prefs.getString("Ctoken");
    LoginModel? model = await SharedPreference.getLoginModel();
    Response response = await _network.getData(
        url: 'getGrades', token: cToken ?? model!.token!);
    if (response.statusCode == 200) {
      return GradesListModel.fromJson(jsonDecode(response.body));
    } else {
      throw (ServerException());
    }
  }

  @override
  Future<SectionsListModel> getSections() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cToken = prefs.getString("Ctoken");
    LoginModel? model = await SharedPreference.getLoginModel();
    Response response = await _network.getData(
        url: 'getSections', token: cToken ?? model!.token!);
    if (response.statusCode == 200) {
      return SectionsListModel.fromJson(jsonDecode(response.body));
    } else {
      throw (ServerException());
    }
  }
}
