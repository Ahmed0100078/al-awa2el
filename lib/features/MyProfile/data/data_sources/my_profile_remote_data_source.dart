import 'dart:convert';
import 'package:http/http.dart';
import 'package:logging/logging.dart';
import 'package:madaresco/Util/SharedPrefernce.dart';
import 'package:madaresco/core/Network/custom_multi_part.dart' as cu;
import 'package:madaresco/core/Network/network.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/features/Login/data/remote/models/login_model.dart';
import 'package:madaresco/features/MyProfile/data/models/my_profile_model.dart'
    as p;
import 'package:madaresco/features/MyProfile/domain/entities/edit_profile_entity.dart';

abstract class MyProfileRemoteDataSource {
  /// Throws [ServerException]
  Future<p.MyProfileModel> getProfile();
  Future<p.MyProfileModel> editProfile(EditProfileEntity entity);
}

class MyProfileRemoteDataSourceImpl implements MyProfileRemoteDataSource {
  Network _network;
  final Logger _logger = Logger('MyProfileRemoteDataSourceImpl');

  MyProfileRemoteDataSourceImpl({
    required Network network,
  }) : _network = network;

  @override
  Future<p.MyProfileModel> getProfile() async {
    LoginModel? model = await SharedPreference.getLoginModel();
    Response response = await _network.getData(url: 'me', token: model!.token!);
    if (response.statusCode == 200) {
      return p.MyProfileModel.fromJson(jsonDecode(response.body));
    } else {
      throw (ServerException());
    }
  }

  @override
  Future<p.MyProfileModel> editProfile(EditProfileEntity entity,
      {double? lat, double? long}) async {
    LoginModel? model = await SharedPreference.getLoginModel();
    var request = cu.MultipartRequest(
      'POST',
      Uri.parse(_network.endPoint + 'me/update'),
      onProgress: (int bytes, int total) {
        final progress = bytes / total;

        print('progress: ${(progress * 100).toInt()}% ($bytes/$total)');
      },
    );
    request.headers.addAll({
      'Authorization': 'Bearer ${model!.token}',
      'Accept': 'application/json',
    });
    if (entity.image.path != '') {
      request.files
          .add(await MultipartFile.fromPath('avatar', entity.image.path));
    }
    request.fields.addAll({
      '_method': 'PUT',
      'name': entity.name,
      'phone': entity.phone,
      'email': entity.email,
      'lat': '$lat',
      'lng': '$long'
    });
    var res = await request.send();

    final respStr = await res.stream.bytesToString();
    if (res.statusCode == 201 || res.statusCode == 200) {
      var profileModel = p.MyProfileModel.fromJson(jsonDecode(respStr));

      LoginModel loginModel = LoginModel(
          data: LoginDatas(
              id: profileModel.data!.id!,
              name: profileModel.data!.name!,
              email: profileModel.data!.email!,
              isActive: true,
              avatar: profileModel.data!.avatar!,
              about: profileModel.data!.about!,
              isConnected: profileModel.data!.isConnected!,
              mobile: profileModel.data!.mobile!,
              school: School(
                  name: profileModel.data!.school!.name!,
                  id: profileModel.data!.school!.id!,
                  logo: profileModel.data!.school!.logo!,
                  schoolCode: profileModel.data!.school!.schoolCode!),
              section: Section(
                name: profileModel.data?.section?.name ?? '',
                id: profileModel.data?.section?.id ?? 0,
                grade: Grade(
                  id: profileModel.data?.section?.grade?.id ?? 0,
                  name: profileModel.data?.section?.grade?.name ?? '',
                  stage: Stage(
                    id: profileModel.data?.section?.grade?.stage?.id ?? 0,
                    name: profileModel.data?.section?.grade?.stage?.name ?? '',
                  ),
                ),
              ),
              type: profileModel.data!.type!,
              warnings: profileModel.data?.warnings
                      ?.map((e) => Warning(
                            id: e.id!,
                            date: e.date!,
                            reason: e.reason!,
                          ))
                      .toList() ??
                  []),
          token: profileModel.token!);
      SharedPreference.setLoginModel(loginModel);
      return profileModel;
    } else {
      _logger.severe(res.statusCode.toString() + '' + respStr);
      throw (ServerException());
    }
  }
}
