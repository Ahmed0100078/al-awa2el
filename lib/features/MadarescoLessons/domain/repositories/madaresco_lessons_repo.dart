import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/MadarescoLessons/domain/entities/madaresco_lessons_entitiy.dart';

abstract class MadarescoLessonsRepo {
  Future<Either<Failure, MadarescoLessonsEntity>> getMadarescoLessons(
      [int stageId, int gradeId, String term, int page = 1]);
}
