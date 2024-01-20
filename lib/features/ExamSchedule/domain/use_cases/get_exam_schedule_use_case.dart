import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/ExamSchedule/domain/entities/exam_schedule_entity.dart';
import 'package:madaresco/features/ExamSchedule/domain/repositories/exam_schedule_repo.dart';

class GetExamScheduleUseCase {
  ExamScheduleRepo _repo;

  GetExamScheduleUseCase({
    required ExamScheduleRepo repo,
  }) : _repo = repo;

  Future<Either<Failure, ExamScheduleEntity>> call(int id) async {
    return await _repo.getExamSchedule(id);
  }
}
