import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/Notifications/data/data_sources/notifications_remote_data_source.dart';
import 'package:madaresco/features/Notifications/domain/entities/notification_entity.dart';
import 'package:madaresco/features/Notifications/domain/repositories/notification_repo.dart';

class NotificationsRepoImpl implements NotificationRepo {
  NotificationsRemoteDataSource _remoteDataSource;

  NotificationsRepoImpl({
    required NotificationsRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, NotificationsEntity>> getNotifications() async {
    try {
      return Right(await _remoteDataSource.getNotifications());
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
