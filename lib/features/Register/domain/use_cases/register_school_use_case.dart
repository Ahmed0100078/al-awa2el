import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/Register/domain/entities/item_entity.dart';
import 'package:madaresco/features/Register/domain/entities/send_entity.dart';
import 'package:madaresco/features/Register/domain/repositories/register_repo.dart';

class RegisterSchoolUseCase {
  RegisterRepo _repo;

  RegisterSchoolUseCase({
    required RegisterRepo repo,
  }) : _repo = repo;

  Future<Either<Failure, Item>> call(SendEntity sendEntity) async {
    return await _repo.registerSchool(sendEntity);
  }
}
