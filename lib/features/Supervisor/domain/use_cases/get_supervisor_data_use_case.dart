import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/Supervisor/domain/entities/supervisor_entity.dart';
import 'package:madaresco/features/Supervisor/domain/repositories/supervisor_repo.dart';

class GetSupervisorDataUseCase {
  final SupervisorRepo _repo;

  const GetSupervisorDataUseCase({
    required SupervisorRepo repo,
  }) : _repo = repo;

  Future<Either<Failure, SupervisorEntity>> call() async {
    return await _repo.getUserInfo();
  }
}
