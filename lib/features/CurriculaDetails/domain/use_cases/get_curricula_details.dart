import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/CurriculaDetails/domain/entities/curricula_details_entity.dart';
import 'package:madaresco/features/CurriculaDetails/domain/repositories/curricula_details_repo.dart';

class GetCurriculaDetailsUseCase {
  CurriculaDetailsRepo _repo;

  GetCurriculaDetailsUseCase({
    required CurriculaDetailsRepo repo,
  }) : _repo = repo;
  Future<Either<Failure, CurriculaDetailsEntity>> call(int id) async {
    return await _repo.getCurriculaDetails(id);
  }
}
