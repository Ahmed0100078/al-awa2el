import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/Register/domain/entities/register_entity.dart';
import 'package:madaresco/features/Register/domain/entities/send_entity.dart';
import 'package:madaresco/features/Register/domain/repositories/register_repo.dart';

class RegisterTeacherUseCase {
  RegisterRepo _repo;

  RegisterTeacherUseCase({
    required RegisterRepo repo,
  }) : _repo = repo;

  Future<Either<Failure, RegisterEntity>> call(SendEntity sendEntity) async {
    return await _repo.registerTeacher(sendEntity);
  }
}
