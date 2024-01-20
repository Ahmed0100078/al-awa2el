import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/Schedule/data/data_sources/schedule_remote_data_source.dart';
import 'package:madaresco/features/Schedule/domain/entities/schedule_entity.dart';
import 'package:madaresco/features/Schedule/domain/repositories/schedule_repo.dart';

class ScheduleRepoImpl implements ScheduleRepo {
  ScheduleRemoteDataSource _remoteDataSource;

  ScheduleRepoImpl({
    required ScheduleRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, ScheduleEntity>> getSchedules(int day) async {
    try {
      final schedule = await _remoteDataSource.getSchedule(day);
      return Right(schedule);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
