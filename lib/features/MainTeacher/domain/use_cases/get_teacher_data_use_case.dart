import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/MainTeacher/domain/entities/main_teacher_entity.dart';
import 'package:madaresco/features/MainTeacher/domain/repositories/main_teacher_repo.dart';

class GetTeacherDataUseCase {
  final MainTeacherRepo _repo;

  const GetTeacherDataUseCase({
    required MainTeacherRepo repo,
  }) : _repo = repo;

  Future<Either<Failure, MainTeacherEntity>> call() async {
    return await _repo.getUserInfo();
  }
}
