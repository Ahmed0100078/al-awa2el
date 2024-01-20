import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/AllTeacher/domain/entities/all_teachers_entity.dart';
import 'package:madaresco/features/AllTeacher/domain/repositories/all_teachers_repo.dart';

class GetAllTeachersUseCase {
  AllTeachersRepo _repo;

  GetAllTeachersUseCase({
    required AllTeachersRepo repo,
  }) : _repo = repo;

  Future<Either<Failure, AllTeachersEntity>> call([int page = 1]) async {
    return await _repo.getAllTeachers(page);
  }
}
