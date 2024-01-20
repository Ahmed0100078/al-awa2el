import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/LessonDetails/domain/entities/lesson_details_entity.dart';

abstract class LessonDetailsRepo {
  Future<Either<Failure, LessonDetailsEntity>> getLessonDetails(int lessonId);
}
