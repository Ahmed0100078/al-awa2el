import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/AddOnlineLesson/data/data_sources/add_online_lesson_remote_data_source.dart';
import 'package:madaresco/features/AddOnlineLesson/domain/entities/add_online_lesson_entity.dart';
import 'package:madaresco/features/AddOnlineLesson/domain/entities/students_entity.dart';
import 'package:madaresco/features/AddOnlineLesson/domain/repositories/add_online_lesson_repo.dart';
import 'package:madaresco/features/Register/data/models/stages_model.dart';

class AddOnlineLessonRepoImpl implements AddOnlineLessonRepo {
  final AddOnlineLessonRemoteDataSource _remoteDataSource;

  const AddOnlineLessonRepoImpl({
    required AddOnlineLessonRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, bool>> addLesson(
      AddOnlineLessonEntity addOnlineLessonEntity) async {
    try {
      return Right(await _remoteDataSource.addLesson(addOnlineLessonEntity));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, StagesModel>> getStages() async {
    try {
      return Right(await _remoteDataSource.getStages());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, StudentsEntity>> getStudents(
      int sectionId /*,[int page = 1]*/) async {
    try {
      return Right(await _remoteDataSource.getStudents(sectionId /*,page*/));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
