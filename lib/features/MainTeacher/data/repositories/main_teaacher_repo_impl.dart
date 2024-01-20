import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/Main/domain/entities/NotEntity.dart';
import 'package:madaresco/features/MainTeacher/data/remote/data_sources/main_teacher_remote_data_source.dart';
import 'package:madaresco/features/MainTeacher/domain/entities/main_teacher_entity.dart';
import 'package:madaresco/features/MainTeacher/domain/repositories/main_teacher_repo.dart';

class MainTeacherRepoImpl implements MainTeacherRepo {
  MainTeacherRemoteDataSource _remoteDataSource;

  MainTeacherRepoImpl({
    required MainTeacherRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, MainTeacherEntity>> getUserInfo() async {
    try {
      final teacherInfo = await _remoteDataSource.getTeacherInfo();
      return Right(teacherInfo);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, NotEntity>> getNotifications() async {
    try {
      final mainNotification = await _remoteDataSource.getMainNotifications();
      return Right(mainNotification);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
