import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/Curricula/domain/entities/curricula_entity.dart';
import 'package:madaresco/features/Curricula/domain/entities/filter_entity.dart';

abstract class CurriculaRepo {
  Future<Either<Failure, CurriculaEntity>> getCurricula(
      [int stageId, int gradeId, int subjectId, String term, int page = 1]);
  Future<Either<Failure, FilterEntity>> getStages();
  Future<Either<Failure, FilterEntity>> getGrades(int stageId);
  Future<Either<Failure, FilterEntity>> getSubjects(int gradeId);
}
