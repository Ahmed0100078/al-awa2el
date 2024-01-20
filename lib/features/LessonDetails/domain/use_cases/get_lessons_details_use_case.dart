import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/LessonDetails/domain/entities/lesson_details_entity.dart';
import 'package:madaresco/features/LessonDetails/domain/repositories/lesson_details_repo.dart';

class GetLessonsDetailsUseCase {
  LessonDetailsRepo _repo;

  GetLessonsDetailsUseCase({
    required LessonDetailsRepo repo,
  }) : _repo = repo;

  Future<Either<Failure, LessonDetailsEntity>> call(int lessonId) async {
    return await _repo.getLessonDetails(lessonId);
  }
}
