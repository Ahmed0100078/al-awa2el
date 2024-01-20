import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/ChatWithPerson/domain/entities/chat_entity.dart';
import 'package:madaresco/features/ChatWithPerson/domain/repositories/chat_repo.dart';

class GetChatUseCase {
  ChatRepo _repo;

  GetChatUseCase({
    required ChatRepo repo,
  }) : _repo = repo;

  Future<Either<Failure, ChatEntity>> call(String url, [int page = 1]) async {
    return await _repo.getConversationByUser(url, page);
  }
}
