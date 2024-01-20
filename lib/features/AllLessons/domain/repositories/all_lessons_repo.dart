import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/AllLessons/domain/entities/all_lessons_entity.dart';

abstract class AllLessonsRepo {
  Future<Either<Failure, AllLessonsEntity>> getLessons(int id, [int page = 1]);
}
