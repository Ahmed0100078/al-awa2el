import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/LessonDetails/data/data_sources/get_lesson_details_remote_data_source.dart';
import 'package:madaresco/features/LessonDetails/domain/entities/lesson_details_entity.dart';
import 'package:madaresco/features/LessonDetails/domain/repositories/lesson_details_repo.dart';

class LessonDetailsRepoImpl implements LessonDetailsRepo {
  GetLessonDetailsRemoteDataSource _remoteDataSource;

  LessonDetailsRepoImpl({
    required GetLessonDetailsRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, LessonDetailsEntity>> getLessonDetails(
      int lessonId) async {
    try {
      final lesson = await _remoteDataSource.getLessonDetails(lessonId);
      return Right(lesson);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
