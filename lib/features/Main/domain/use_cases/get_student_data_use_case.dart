import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/Main/domain/entities/MainEntity.dart';
import 'package:madaresco/features/Main/domain/repositories/main_repo.dart';

class GetStudentDataUseCase {
  final MainRepo _repo;

  const GetStudentDataUseCase({
    required MainRepo repo,
  }) : _repo = repo;

  Future<Either<Failure, MainEntity>> call() async {
    return await _repo.getUserInfo();
  }
}
