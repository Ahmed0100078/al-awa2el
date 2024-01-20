import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/UploadLesson/domain/entities/upload_lesson_entity.dart';
import 'package:madaresco/features/UploadLesson/domain/repositories/upload_lesson_repo.dart';

class UploadLessonUseCase {
  UploadLessonRepo _repo;

  UploadLessonUseCase({
    required UploadLessonRepo repo,
  }) : _repo = repo;

  Future<Either<Failure, bool>> call(UploadLessonEntity lessonEntity) async {
    return await _repo.uploadLesson(lessonEntity);
  }
}
