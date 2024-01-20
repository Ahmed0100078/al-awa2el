import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/ChatWithPerson/domain/entities/chat_entity.dart';
import 'package:madaresco/features/ChatWithPerson/domain/repositories/chat_repo.dart';

class SendMessageUseCase {
  ChatRepo _repo;

  SendMessageUseCase({
    required ChatRepo repo,
  }) : _repo = repo;

  Future<Either<Failure, MessageEntity>> call(
      int roomId, String message, String socketID) async {
    return await _repo.sendMessage(roomId, message, socketID);
  }
}
