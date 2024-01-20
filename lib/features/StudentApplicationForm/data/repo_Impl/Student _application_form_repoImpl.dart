import 'dart:convert';
import 'package:dio/dio.dart' as dioClient;
import 'package:http/http.dart';
import '../../../../core/Network/network.dart';

class StudentApplicationRepoImpl {
  Network network = Network();

  Future<dioClient.Response> registerStudentForm(body) async {
    dioClient.Response response =
        await network.postDataWithDio(url: 'forms/students', body: body);
    return response;
  }

  Future<Response> getSchools([int page = 1]) async {
    Response response =
        await network.getData(url: 'schools?without_pagination=1');
    return response;
  }

  List<String> getSchoolIds(Response response) {
    List<String> schoolIds = [];
    Map<String, dynamic> responseData = json.decode(response.body);
    List<dynamic> options = responseData['data']['options'];
    for (var option in options) {
      int schoolId = option['id'];
      schoolIds.add(schoolId.toString());
    }
    return schoolIds;
  }
}
