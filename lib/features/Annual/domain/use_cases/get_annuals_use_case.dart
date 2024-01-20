import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/Annual/domain/entities/annual_entity.dart';
import 'package:madaresco/features/Annual/domain/repositories/annual_repo.dart';

class GetAnnualsUseCase {
  AnnualRepo _repo;

  GetAnnualsUseCase({
    required AnnualRepo repo,
  }) : _repo = repo;

  Future<Either<Failure, AnnualEntity>> call() async {
    return await _repo.getAnnuals();
  }
}
