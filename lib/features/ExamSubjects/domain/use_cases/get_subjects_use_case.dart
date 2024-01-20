import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/ExamSubjects/domain/entities/exam_subjects_entity.dart';
import 'package:madaresco/features/ExamSubjects/domain/repositories/exam_subjects_repo.dart';

class GetExamSubjectsUseCase {
  ExamSubjectsRepo _repo;

  GetExamSubjectsUseCase({
    required ExamSubjectsRepo repo,
  }) : _repo = repo;

  Future<Either<Failure, ExamSubjectsEntity>> call({int page = 1}) async {
    return await _repo.getSubjects(page: page);
  }
}
