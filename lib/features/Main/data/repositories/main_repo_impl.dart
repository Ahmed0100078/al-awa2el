import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/Main/data/remote/data_sources/main_remote_data_source.dart';
import 'package:madaresco/features/Main/domain/entities/MainEntity.dart';
import 'package:madaresco/features/Main/domain/entities/NotEntity.dart';
import 'package:madaresco/features/Main/domain/repositories/main_repo.dart';
import 'package:madaresco/features/Notifications/data/models/notifications_model.dart';

class MainRepoImpl implements MainRepo {
  MainRemoteDataSource _remoteDataSource;

  MainRepoImpl({
    required MainRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, MainEntity>> getUserInfo() async {
    try {
      final studentInfo = await _remoteDataSource.getStudentInfo();
      return Right(studentInfo);
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

  @override
  Future<Either<Failure, NotificationsModel>> getNotificationsCount() async {
    try {
      final mainNotification = await _remoteDataSource.getNotifications();
      return Right(mainNotification);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
