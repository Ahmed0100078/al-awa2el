import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/ExamResult/domain/repositories/exam_results_repo.dart';

class GetExamsResultsPdfUseCase {
  ExamResultsRepo _repo;

  GetExamsResultsPdfUseCase({
    required ExamResultsRepo repo,
  }) : _repo = repo;

  Future<Either<Failure, String>> call() async {
    return await _repo.getExamResultsPdf();
  }
}
