import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/Register/domain/entities/item_entity.dart';
import 'package:madaresco/features/Register/domain/repositories/register_repo.dart';

class GetStagesUseCase {
  final RegisterRepo _repo;

  const GetStagesUseCase({
    required RegisterRepo repo,
  }) : _repo = repo;

  Future<Either<Failure, ItemsEntity>> call(int schoolId) async {
    return await _repo.getStages(schoolId);
  }
}
