import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/ExamSubjects/data/data_sources/exam_subjects_remote_data_source.dart';
import 'package:madaresco/features/ExamSubjects/domain/entities/exam_subjects_entity.dart';
import 'package:madaresco/features/ExamSubjects/domain/repositories/exam_subjects_repo.dart';

class ExamSubjectsRepoImpl implements ExamSubjectsRepo {
  ExamSubjectsRemoteDataSource _remoteDataSource;

  ExamSubjectsRepoImpl({
    required ExamSubjectsRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, ExamSubjectsEntity>> getSubjects(
      {int page = 1}) async {
    try {
      final examSubjects = await _remoteDataSource.getSubjects(page: page);
      return Right(examSubjects);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
