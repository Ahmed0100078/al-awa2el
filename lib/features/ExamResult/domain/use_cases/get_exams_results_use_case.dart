import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/ExamResult/domain/entities/exam_result_entity.dart';
import 'package:madaresco/features/ExamResult/domain/repositories/exam_results_repo.dart';

class GetExamsResultsUseCase {
  ExamResultsRepo _repo;

  GetExamsResultsUseCase({
    required ExamResultsRepo repo,
  }) : _repo = repo;

  Future<Either<Failure, ExamResultEntity>> call() async {
    return await _repo.getExamResults();
  }
}
