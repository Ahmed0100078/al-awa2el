import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/ChatWithPerson/domain/entities/pusher_entity.dart';
import 'package:madaresco/features/ChatWithPerson/domain/repositories/chat_repo.dart';

class GetPusherDataUseCase {
  ChatRepo _repo;

  GetPusherDataUseCase({
    required ChatRepo repo,
  }) : _repo = repo;
  Future<Either<Failure, PusherEntity>> call() async {
    return await _repo.getPusherData();
  }
}
