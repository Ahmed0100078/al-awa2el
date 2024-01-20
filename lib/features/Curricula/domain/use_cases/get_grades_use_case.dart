import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/Curricula/domain/entities/filter_entity.dart';
import 'package:madaresco/features/Curricula/domain/repositories/curricula_repo.dart';

class GetCurriculaGradesUseCase {
  CurriculaRepo _repo;

  GetCurriculaGradesUseCase({
    required CurriculaRepo repo,
  }) : _repo = repo;
  Future<Either<Failure, FilterEntity>> call(int id) async {
    return await _repo.getGrades(id);
  }
}
