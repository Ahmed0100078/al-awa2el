import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/ExamResult/domain/entities/exam_result_entity.dart';

abstract class ExamResultsRepo {
  Future<Either<Failure, ExamResultEntity>> getExamResults();
  Future<Either<Failure, String>> getExamResultsPdf();
}
