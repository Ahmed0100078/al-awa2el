import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/OnlineLessons/data/data_sources/online_lessons_remote_data_source.dart';
import 'package:madaresco/features/OnlineLessons/domain/entities/online_lessons_entity.dart';
import 'package:madaresco/features/OnlineLessons/domain/repositories/online_lesson_repo.dart';

class OnlineLessonsRepoImpl implements OnlineLessonRepo {
  final OnlineLessonsRemoteDataSource _remoteDataSource;

  const OnlineLessonsRepoImpl({
    required OnlineLessonsRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, OnlineLessonsEntity>> getLessons(
      [int page = 1]) async {
    try {
      return Right(await _remoteDataSource.getOnlineLessons(page));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
