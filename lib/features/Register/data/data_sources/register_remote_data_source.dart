import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:madaresco/Util/SharedPrefernce.dart';
import 'package:madaresco/core/Network/custom_multi_part.dart' as cu;
import 'package:madaresco/core/Network/network.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/features/Login/data/remote/models/login_model.dart';
import 'package:madaresco/features/Register/data/models/grades_model.dart';
import 'package:madaresco/features/Register/data/models/register_model.dart';
import 'package:madaresco/features/Register/data/models/schools_models.dart'
    as p;
import 'package:madaresco/features/Register/data/models/sections_model.dart';
import 'package:madaresco/features/Register/data/models/stages_model.dart';
import 'package:madaresco/features/Register/domain/entities/register_entity.dart';
import 'package:madaresco/features/Register/domain/entities/send_entity.dart';

abstract class RegisterRemoteDataSource {
  /// Throws[ServerException]
  Future<RegisterEntity> registerTeacher(SendEntity sendEntity);
  Future<RegisterEntity> registerStudent(SendEntity sendEntity);
  Future<SchoolModel> registerSchool(SendEntity sendEntity);
  Future<p.SchoolModel> getSchools();
  Future<SectionsModel> getSections(int gradeId);
  Future<StagesModel> getStages(int schoolId);
  Future<GradesModel> getGrades(int stageId);
}

class RegisterRemoteDataSourceImpl implements RegisterRemoteDataSource {
  Network _network;
  RegisterRemoteDataSourceImpl({
    required Network network,
  }) : _network = network;

  @override
  Future<SchoolModel> registerSchool(SendEntity sendEntity) async {
    Response response = await _network.postData(url: 'auth/register', body: {
      'name': sendEntity.name,
      'email': sendEntity.email ?? '',
      'password': sendEntity.password,
      'password_confirmation': sendEntity.confirmPassword,
      'type': 'school',
      'school_manager_name': sendEntity.managerName,
      'country': sendEntity.country,
      'governorate': sendEntity.city,
      'address': sendEntity.address
    });
    if (response.statusCode == 201) {
      return SchoolModel.fromJson(jsonDecode(response.body));
    } else {
      throw (ServerException());
    }
  }

  @override
  Future<RegisterEntity> registerStudent(SendEntity sendEntity) async {
    var request = cu.MultipartRequest(
      'POST',
      Uri.parse(_network.endPoint + 'auth/register'),
      onProgress: (int bytes, int total) {
        final progress = bytes / total;
        print('progress: ${(progress * 100).toInt()}% ($bytes/$total)');
      },
    );
    request.headers.addAll({
      'Accept': 'application/json',
    });

    MultipartFile multipartFile = await MultipartFile.fromPath(
      'avatar',
      sendEntity.image!.path,
      filename: '${sendEntity.name}',
    );

    request.files.add(multipartFile);
    request.fields.addAll({
      'name': sendEntity.name!,
      'email': sendEntity.email ?? '',
      'mobile': sendEntity.mobile ?? '',
      'password': sendEntity.password!,
      'password_confirmation': sendEntity.confirmPassword!,
      'section_id': sendEntity.sectionId.toString(),
      'school_id': sendEntity.schoolId.toString()
    });
    var res = await request.send();
    final respStr = await res.stream.bytesToString();
    if (res.statusCode == 201) {
      LoginModel model = LoginModel.fromJson(jsonDecode(respStr));
      SharedPreference.setLoginModel(model);
      return RegisterEntity(
          name: model.name!,
          token: model.token!,
          section: model.data!.section!.name!,
          school: model.data!.school!.name!);
    } else {
      throw (ServerException());
    }
  }

  @override
  Future<RegisterEntity> registerTeacher(SendEntity sendEntity) async {
    var request = cu.MultipartRequest(
      'POST',
      Uri.parse(_network.endPoint + 'auth/register'),
      onProgress: (int bytes, int total) {
        final progress = bytes / total;

        print('progress: ${(progress * 100).toInt()}% ($bytes/$total)');
      },
    );
    request.headers.addAll({
      'Accept': 'application/json',
    });

    MultipartFile multipartFile = await MultipartFile.fromPath(
      'avatar',
      sendEntity.image!.path,
      filename: '${sendEntity.name}',
    );

    request.files.add(multipartFile);
    request.fields.addAll({
      'name': sendEntity.name!,
      'email': sendEntity.email ?? '',
      'password': sendEntity.password!,
      'password_confirmation': sendEntity.confirmPassword!,
      'school_id': sendEntity.schoolId.toString(),
      'type': 'teacher'
    });
    var res = await request.send();

    final respStr = await res.stream.bytesToString();
    if (res.statusCode == 201) {
      LoginModel model = LoginModel.fromJson(jsonDecode(respStr));
      SharedPreference.setLoginModel(model);
      return RegisterEntity(
          name: model.name!,
          token: model.token!,
          section: model.data!.section?.name ?? '',
          school: model.data!.school?.name ?? '');
    } else {
      final jsonErr = json.decode(respStr);
      String errMsg =
          jsonErr['message'] != null ? jsonErr['message'].toString() : "";
      String errors =
          jsonErr['errors'] != null ? jsonErr['errors'].toString() : "";

      log(respStr.toString());

      throw (ServerException(errMsg: errMsg + "\n" + errors));
    }
  }

  @override
  Future<p.SchoolModel> getSchools([int page = 1]) async {
    Response response =
        await _network.getData(url: 'schools?without_pagination=1');
    if (response.statusCode == 200) {
      return p.SchoolModel.fromJson(jsonDecode(response.body));
    } else {
      throw (ServerException());
    }
  }

  @override
  Future<GradesModel> getGrades(int stageId) async {
    print('stageId : $stageId');
    Response response = await _network.getData(
        url: 'grades?without_pagination=1&stage_id=$stageId');
    if (response.statusCode == 200) {
      print("aloo ==========>>>>> ${jsonDecode(response.body)}");//['data']
      return GradesModel.fromJson(jsonDecode(response.body));
    } else {
      throw (ServerException());
    }
  }

  @override
  Future<SectionsModel> getSections(int gradesId) async {
    Response response = await _network.getData(
        url: 'sections?grade_id=$gradesId&without_pagination=1');
    if (response.statusCode == 200) {
      return SectionsModel.fromJson(jsonDecode(response.body));
    } else {
      throw (ServerException());
    }
  }

  @override
  Future<StagesModel> getStages(int schoolId) async {
    print('schoolId : $schoolId');
    Response response = await _network.getData(
        url: 'stages/$schoolId&without_pagination=1');
    if (response.statusCode == 200) {
      return StagesModel.fromJson(jsonDecode(response.body));
    } else {
      throw (ServerException());
    }
  }
}
