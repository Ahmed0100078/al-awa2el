import 'dart:developer';

import 'package:dio/dio.dart' as dioClient;
import 'package:http/http.dart';

import '../../../../core/Network/network.dart';

class EmploymentFormRepoImpl {
  Network network = Network();

  Future<dioClient.Response> registerEmploymentForm(body) async {
    dioClient.Response response =
        await network.postDataWithDio(url: 'forms/employments', body: body);
    log('${response.data}');
    return response;
  }

  Future<Response> getSchools([int page = 1]) async {
    Response response =
        await network.getData(url: 'schools?without_pagination=1');
    return response;
  }
}
