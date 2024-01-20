import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:dio/dio.dart' as dio;
import 'package:http/http.dart';
import 'package:logging/logging.dart';
import 'package:madaresco/Util/SharedPrefernce.dart';
import 'package:madaresco/core/Network/custom_multi_part.dart' as cu;
import 'package:madaresco/core/Network/network.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/features/Login/data/remote/models/login_model.dart';
import 'package:madaresco/features/Register/data/models/stages_model.dart';
import 'package:madaresco/features/UploadLesson/data/models/subjects_model.dart';
import 'package:madaresco/features/UploadLesson/domain/entities/upload_lesson_entity.dart';

abstract class UploadLessonRemoteDataSource {
  /// Throws [ServerException]
  Future<StagesModel> getStage();

  Future<SubjectsModel> getSubjects(int gradeId);

  Future<bool> uploadLesson(UploadLessonEntity lessonEntity);
}

class UploadLessonRemoteDataSourceImpl implements UploadLessonRemoteDataSource {
  Network _network;
  final Logger _logger = Logger('UploadLessonRemoteDataSourceImpl');

  UploadLessonRemoteDataSourceImpl({
    required Network network,
  }) : _network = network;

  @override
  Future<StagesModel> getStage() async {
    LoginModel? model = await SharedPreference.getLoginModel();
    Response response = await _network.getData(
        url: 'stages?without_pagination=1', token: model!.token!);
    if (response.statusCode == 200) {
      return StagesModel.fromJson(jsonDecode(response.body));
    } else {
      throw (ServerException());
    }
  }

  @override
  Future<bool> uploadLesson(UploadLessonEntity lessonEntity) async {
    LoginModel? model = await SharedPreference.getLoginModel();
    var request = cu.MultipartRequest(
      'POST',
      Uri.parse(_network.endPoint + 'lessons'),
      onProgress: (int bytes, int total) {
        final progress = bytes / total;

        print('progress: ${(progress * 100).toInt()}% ($bytes/$total)');
      },
    );
    request.headers.addAll({
      'Authorization': 'Bearer ${model!.token}',
      'Accept': 'application/json',
    });
    if (lessonEntity.images!.isNotEmpty) {
      for (int i = 0; i < lessonEntity.images!.length; i++) {
        ByteData byteData = await lessonEntity.images![i].getByteData();
        List<int> imageData = byteData.buffer.asUint8List();

        MultipartFile multipartFile = MultipartFile.fromBytes(
          'images[]',
          imageData,
          filename: '${lessonEntity.images![i].name}',
        );
        request.files.add(multipartFile);
      }
    }
    if (lessonEntity.video != null) {
      request.files
          .add(await MultipartFile.fromPath('video', lessonEntity.video!.path));
    }
    if (lessonEntity.audio != null) {
      request.files
          .add(await MultipartFile.fromPath('audio', lessonEntity.audio!.path));
    }
    if (lessonEntity.externalLink != null && lessonEntity.externalLink != "") {
      request.fields.addAll({'outside_link': lessonEntity.externalLink!});
    }
    print('55555555/SectionId=${lessonEntity.sectionId}');
    print('55555555/subjectId=${lessonEntity.subjectId}');
    request.fields.addAll({
      'name': lessonEntity.name!,
      'description': lessonEntity.description!,
      'section_id': lessonEntity.sectionId.toString(),
      'subject_id': lessonEntity.subjectId.toString(),
    });

    if (lessonEntity.attachments!.isNotEmpty) {
      for (int i = 0; i < lessonEntity.attachments!.length; i++) {
        MultipartFile multipartFile = await MultipartFile.fromPath(
            'attachments[]', lessonEntity.attachments![i].path);
        request.files.add(multipartFile);
      }
    }
    var res = await request.send();

    final respStr = await res.stream.bytesToString();
    if (res.statusCode == 201 || res.statusCode == 200) {
      _logger.fine(respStr);
      return true;
    } else {
      _logger.severe(res.statusCode.toString() + '' + respStr);
      throw (ServerException());
    }
  }

  @override
  Future<SubjectsModel> getSubjects(int gradeId) async {
    await SharedPreference.getLoginModel();
    dio.Response response = await dio.Dio().get(
        "${_network.endPoint}subjects?grade_id=$gradeId&without_pagination=1",
        options: dio.Options(
          headers: {
            // 'Accept': 'application/json',
            // 'Authorization': 'Bearer ${model!.token}',
          },
        ));
    log('get subjects calllled0000000000000000000000000000000.  ${response.realUri}.   headers ${response.headers}.   response is ${response.data}');
    // if (response.statusCode == 200) {
    return SubjectsModel.fromJson(response.data);
    // }
    // else {
    //   throw (ServerException());
    // }
  }
}
