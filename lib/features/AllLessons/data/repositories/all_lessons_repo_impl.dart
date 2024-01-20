import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/AllLessons/data/data_sources/all_lessons_remote_data_source.dart';
import 'package:madaresco/features/AllLessons/domain/entities/all_lessons_entity.dart';
import 'package:madaresco/features/AllLessons/domain/repositories/all_lessons_repo.dart';

class AllLessonsRepoImpl implements AllLessonsRepo {
  AllLessonsRemoteDataSource _remoteDataSource;

  AllLessonsRepoImpl({
    required AllLessonsRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, AllLessonsEntity>> getLessons(int id,
      [int page = 1]) async {
    try {
      final lessons = await _remoteDataSource.getLessons(id, page);
      return Right(lessons);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
