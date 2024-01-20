import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/AddOnlineLesson/domain/entities/students_entity.dart';
import 'package:madaresco/features/AddOnlineLesson/domain/repositories/add_online_lesson_repo.dart';

class GetStudentsUseCase {
  final AddOnlineLessonRepo _repo;

  const GetStudentsUseCase({
    required AddOnlineLessonRepo repo,
  }) : _repo = repo;

  Future<Either<Failure, StudentsEntity>> call(
    int sectionId,
    /* [int page = 1]*/
  ) async {
    return await _repo.getStudents(
      sectionId, /* page*/
    );
  }
}
