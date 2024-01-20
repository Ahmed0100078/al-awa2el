import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/Schedule/domain/entities/schedule_entity.dart';

abstract class ScheduleRepo {
  Future<Either<Failure, ScheduleEntity>> getSchedules(int day);
}
