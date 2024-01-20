import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/Notifications/domain/entities/notification_entity.dart';
import 'package:madaresco/features/Notifications/domain/repositories/notification_repo.dart';

class GetNotificationsUseCase {
  NotificationRepo _repo;

  GetNotificationsUseCase({
    required NotificationRepo repo,
  }) : _repo = repo;

  Future<Either<Failure, NotificationsEntity>> call() async {
    return await _repo.getNotifications();
  }
}
