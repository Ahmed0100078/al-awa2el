import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/Curricula/domain/entities/filter_entity.dart';
import 'package:madaresco/features/Curricula/domain/repositories/curricula_repo.dart';

class GetCurriculaSubjectsUseCase {
  final CurriculaRepo _repo;

  const GetCurriculaSubjectsUseCase({
    required CurriculaRepo repo,
  }) : _repo = repo;

  Future<Either<Failure, FilterEntity>> call(int gradeId) async {
    return await _repo.getSubjects(gradeId);
  }
}
