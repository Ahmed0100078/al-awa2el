import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/Absence/domain/entities/absence_entity.dart';
import 'package:madaresco/features/Absence/domain/repositories/absence_repo.dart';

class GetAbsenceUseCase {
  AbsenceRepo _repo;

  GetAbsenceUseCase({
    required AbsenceRepo repo,
  }) : _repo = repo;

  Future<Either<Failure, AbsenceEntity>> call([String? date]) async {
    return await _repo.getAbsence(date!);
  }
}
