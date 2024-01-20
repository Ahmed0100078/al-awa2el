import 'dart:convert';
import 'package:http/http.dart';
import 'package:logging/logging.dart';
import 'package:madaresco/Util/SharedPrefernce.dart';
import 'package:madaresco/core/Network/network.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/features/ChatWithPerson/data/models/chat_model.dart';
import 'package:madaresco/features/ChatWithPerson/data/models/message_model.dart';
import 'package:madaresco/features/ChatWithPerson/data/models/pusher_model.dart';
import 'package:madaresco/features/Login/data/remote/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ChatRemoteDataSource {
  /// Throws [ServerException]
  Future<ChatModel> getChatByUser(String url, [int page = 1]);

  Future<MessageModel> sendMessage(int roomId, String message, String socketID);
  Future<PusherModel> getPusher();
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  Network _network;
  final Logger _logger = Logger('ChatRemoteDataSourceImpl');

  ChatRemoteDataSourceImpl({
    required Network network,
  }) : _network = network;

  @override
  Future<ChatModel> getChatByUser(String url, [int page = 1]) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cToken = prefs.getString("Ctoken");
    LoginModel? model = await SharedPreference.getLoginModel();
    print('url=$url');
    print('page=$page');
    Response response = await _network.getData(
        url: 'chat/$url?page=$page',
        token: cToken ?? model!.token!,
        isPrint: false);
    if (response.statusCode == 200) {
      return ChatModel.fromJson(jsonDecode(response.body));
    } else {
      throw (ServerException());
    }
  }

  @override
  Future<MessageModel> sendMessage(
      int roomId, String message, String socketID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cToken = prefs.getString("Ctoken");
    LoginModel? model = await SharedPreference.getLoginModel();
    _network.headers.addAll({'X-Socket-ID': socketID});
    Response response = await _network.postData(
        url: 'chat/rooms/$roomId/send-message',
        body: {'message': message},
        token: cToken ?? model!.token!);
    _logger.warning(_network.headers);
    if (response.statusCode == 201) {
      return MessageModel.fromJson(jsonDecode(response.body));
    } else {
      throw (ServerException());
    }
  }

  @override
  Future<PusherModel> getPusher() async {
    Response response = await _network.getData(
      url: 'broadcasting/pusher',
    );
    if (response.statusCode == 200) {
      return PusherModel.fromJson(jsonDecode(response.body));
    } else {
      throw (ServerException());
    }
  }
}
