import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/Register/domain/entities/item_entity.dart';
import 'package:madaresco/features/UploadLesson/data/data_sources/upload_lesson_remote_data_source.dart';
import 'package:madaresco/features/UploadLesson/domain/entities/upload_lesson_entity.dart';
import 'package:madaresco/features/UploadLesson/domain/repositories/upload_lesson_repo.dart';

class UploadLessonRepoImpl implements UploadLessonRepo {
  UploadLessonRemoteDataSource _remoteDataSource;

  UploadLessonRepoImpl({
    required UploadLessonRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, ItemsEntity>> getStages() async {
    try {
      return Right(await _remoteDataSource.getStage());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> uploadLesson(
      UploadLessonEntity lessonEntity) async {
    try {
      return Right(await _remoteDataSource.uploadLesson(lessonEntity));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, ItemsEntity>> getSubjects(int gradeId) async {
    try {
      return Right(await _remoteDataSource.getSubjects(gradeId));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
