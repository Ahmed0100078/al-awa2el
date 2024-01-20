import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/ExamSubjects/domain/entities/exam_subjects_entity.dart';

abstract class ExamSubjectsRepo {
  Future<Either<Failure, ExamSubjectsEntity>> getSubjects({int page = 1});
}
