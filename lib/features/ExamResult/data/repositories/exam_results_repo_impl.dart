import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/ExamResult/data/data_sources/exam_results_remote_data_source.dart';
import 'package:madaresco/features/ExamResult/domain/entities/exam_result_entity.dart';
import 'package:madaresco/features/ExamResult/domain/repositories/exam_results_repo.dart';

class ExamResultsRepoImpl implements ExamResultsRepo {
  ExamResultsRemoteDataSource _remoteDataSource;

  ExamResultsRepoImpl({
    required ExamResultsRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, ExamResultEntity>> getExamResults() async {
    try {
      final examResults = await _remoteDataSource.getExamResults();
      return Right(examResults);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, String>> getExamResultsPdf() async {
    try {
      final examResults = await _remoteDataSource.getExamResultsPdf();
      return Right(examResults);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
