import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/Schedule/domain/entities/schedule_entity.dart';
import 'package:madaresco/features/Schedule/domain/repositories/schedule_repo.dart';

class GetScheduleUseCase {
  ScheduleRepo _repo;

  GetScheduleUseCase({
    required ScheduleRepo repo,
  }) : _repo = repo;

  Future<Either<Failure, ScheduleEntity>> call(int day) async {
    return await _repo.getSchedules(day);
  }
}
