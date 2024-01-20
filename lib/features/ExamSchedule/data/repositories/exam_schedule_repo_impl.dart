import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/ExamSchedule/data/data_sources/exam_schedule_remote_datasource.dart';
import 'package:madaresco/features/ExamSchedule/domain/entities/exam_schedule_entity.dart';
import 'package:madaresco/features/ExamSchedule/domain/repositories/exam_schedule_repo.dart';

class ExamScheduleRepoImpl implements ExamScheduleRepo {
  ExamScheduleRemoteDataSource _remoteDataSource;

  ExamScheduleRepoImpl({
    required ExamScheduleRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, ExamScheduleEntity>> getExamSchedule(int id) async {
    try {
      final exam = await _remoteDataSource.getExam(id);
      return Right(exam);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
