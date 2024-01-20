import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/OnlineLessons/domain/entities/online_lessons_entity.dart';

abstract class OnlineLessonRepo {
  Future<Either<Failure, OnlineLessonsEntity>> getLessons([int page = 1]);
}
