import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/ManagerWord/domain/entities/manager_word_entity.dart';
import 'package:madaresco/features/ManagerWord/domain/repositories/manager_word_repo.dart';

class GetManagerWordUseCase {
  ManagerWordRepo _repo;

  GetManagerWordUseCase({
    required ManagerWordRepo repo,
  }) : _repo = repo;

  Future<Either<Failure, ManagerWordEntity>> call() async {
    return await _repo.getManagerWord();
  }
}
