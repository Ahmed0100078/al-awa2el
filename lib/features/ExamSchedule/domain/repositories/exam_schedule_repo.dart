import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/ExamSchedule/domain/entities/exam_schedule_entity.dart';

abstract class ExamScheduleRepo {
  Future<Either<Failure, ExamScheduleEntity>> getExamSchedule(int id);
}
