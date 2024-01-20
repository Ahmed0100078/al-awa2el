import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/Curricula/domain/entities/curricula_entity.dart';
import 'package:madaresco/features/Curricula/domain/repositories/curricula_repo.dart';

class GetCurriculaUseCase {
  CurriculaRepo _repo;

  GetCurriculaUseCase({
    required CurriculaRepo repo,
  }) : _repo = repo;

  Future<Either<Failure, CurriculaEntity>> call(
      {int? stageId,
      int? gradeId,
      int? subjectId,
      String? term,
      int page = 1}) async {
    return await _repo.getCurricula(
        stageId ?? 0, gradeId ?? 0, subjectId ?? 0, term ?? "", page);
  }
}
