import 'dart:convert';
import 'package:dio/dio.dart' as dioClient;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:madaresco/Util/SharedPrefernce.dart';
import 'package:madaresco/core/Network/network.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/features/AddOnlineLesson/data/models/students_model.dart';
import 'package:madaresco/features/AddOnlineLesson/domain/entities/add_online_lesson_entity.dart';
import 'package:madaresco/features/Login/data/remote/models/login_model.dart';
import 'package:madaresco/features/Register/data/models/stages_model.dart';

abstract class AddOnlineLessonRemoteDataSource {
  /// Throws [ServerException]
  Future<StagesModel> getStages();
  Future<StudentsModel> getStudents(int sectionID/*, [int page = 1]*/);
  Future<bool> addLesson(AddOnlineLessonEntity entity);
}

class AddOnlineLessonRemoteDataSourceImpl
    implements AddOnlineLessonRemoteDataSource {
  final Network _network;

  const AddOnlineLessonRemoteDataSourceImpl({
    required Network network,
  }) : _network = network;

  @override
  Future<bool> addLesson(AddOnlineLessonEntity entity) async {
    final Map<String, String> headers = {
      'Accept': 'application/json',
    };
    LoginModel? model = await SharedPreference.getLoginModel();
    ValueNotifier<Locale> locale = ValueNotifier(Locale('en', 'US'));
    Map<String, dynamic> body = {
      'section_id': entity.sectionId.toString(),
      'name': entity.name,
      'description': entity.name,
      'subject_id': entity.subjectId.toString(),
      'link': entity.link,
      'students': entity.students,
    };

    if (model!.token != null) {
      headers.addAll({'Authorization': 'Bearer ${model.token}'});
    }

    headers.addAll({'Accept-Language': locale.value.languageCode.toString()});
    var formData = dioClient.FormData.fromMap(body);

    dioClient.Dio dio = dioClient.Dio();
    try{
      print('AddOnlineLessonRemoteDataSource addLesson aloo1');
      await dio.post("${Network().endPoint}lessons",
        data: formData, options: dioClient.Options(headers: headers));
      return true;
    }catch(e){
      print('AddOnlineLessonRemoteDataSource addLesson aloo2');
      throw (ServerException(errMsg: e.toString()));
    }
    // print('AddOnlineLessonRemoteDataSource addLesson aloo1');
    // dioClient.Response response = await dio.post("${Network().endPoint}lessons",
    //     data: formData, options: dioClient.Options(headers: headers));
    // print('AddOnlineLessonRemoteDataSource addLesson aloo2');
    // if (response.statusCode == 200) {//201
    //   return true;
    // } else {
    //   throw (ServerException());
    // }
  }

  @override
  Future<StagesModel> getStages() async {
    Response response =
        await _network.getData(url: 'stages?without_pagination=1');
    if (response.statusCode == 200) {
      // print('aloo from AddOnlineLessonRemoteDataSource getStages ${jsonDecode(response.body)['data']}');
      return StagesModel.fromJson(jsonDecode(response.body));
    } else {
      throw (ServerException());
    }
  }

  @override
  Future<StudentsModel> getStudents(int sectionId/*, [int page = 1]*/) async {
    LoginModel? model = await SharedPreference.getLoginModel();
    Response response = await _network.getData(
        url: 'search/students?section_id=$sectionId',
        token: model!.token!);
    if (response.statusCode == 200) {
      return StudentsModel.fromJson(jsonDecode(response.body));
    } else {
      throw (ServerException());
    }
  }
}
