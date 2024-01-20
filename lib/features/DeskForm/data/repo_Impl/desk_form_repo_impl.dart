import 'dart:developer';

import 'package:dio/dio.dart' as dioClient;
import 'package:http/http.dart';

import '../../../../core/Network/network.dart';

class DeskFormRepoImpl {
  Network network = Network();

  Future<dioClient.Response> registerDeskForm(body) async {
    dioClient.Response response =
        await network.postDataWithDio(url: 'forms/desks', body: body);
    log('${response.data}');
    return response;
  }

  Future<Response> getGrades(schoolId) async {
    Response response = await network.getData(url: 'new/select/stages?school_id=$schoolId'); //we should use this stages/$schoolId&without_pagination=1
    return response;
  }
}
