import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/ChatWithPerson/domain/entities/chat_entity.dart';
import 'package:madaresco/features/ChatWithPerson/domain/entities/pusher_entity.dart';

abstract class ChatRepo {
  Future<Either<Failure, ChatEntity>> getConversationByUser(String url, [int page = 1]);
  Future<Either<Failure, MessageEntity>> sendMessage(int roomId, String message, String socketID);
  Future<Either<Failure, PusherEntity>> getPusherData();
}
