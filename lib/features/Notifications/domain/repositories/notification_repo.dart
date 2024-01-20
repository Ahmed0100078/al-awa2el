import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/Notifications/domain/entities/notification_entity.dart';

abstract class NotificationRepo {
  Future<Either<Failure, NotificationsEntity>> getNotifications();
}
