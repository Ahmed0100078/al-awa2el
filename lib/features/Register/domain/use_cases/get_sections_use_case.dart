import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/Register/domain/entities/item_entity.dart';
import 'package:madaresco/features/Register/domain/repositories/register_repo.dart';

class GetSectionsUseCase {
  final RegisterRepo _repo;

  const GetSectionsUseCase({
    required RegisterRepo repo,
  }) : _repo = repo;

  Future<Either<Failure, ItemsEntity>> call(int gradeId) async {
    return await _repo.getSections(gradeId);
  }
}
