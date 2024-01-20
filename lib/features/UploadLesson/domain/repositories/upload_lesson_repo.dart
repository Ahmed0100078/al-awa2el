import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/Register/domain/entities/item_entity.dart';
import 'package:madaresco/features/UploadLesson/domain/entities/upload_lesson_entity.dart';

abstract class UploadLessonRepo {
  Future<Either<Failure, ItemsEntity>> getStages();
  Future<Either<Failure, ItemsEntity>> getSubjects(int gradeId);
  Future<Either<Failure, bool>> uploadLesson(UploadLessonEntity lessonEntity);
}
