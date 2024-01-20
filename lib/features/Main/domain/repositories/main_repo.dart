import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/Main/domain/entities/MainEntity.dart';
import 'package:madaresco/features/Main/domain/entities/NotEntity.dart';
import 'package:madaresco/features/Notifications/data/models/notifications_model.dart';

abstract class MainRepo {
  Future<Either<Failure, MainEntity>> getUserInfo();
  Future<Either<Failure, NotEntity>> getNotifications();
  Future<Either<Failure, NotificationsModel>> getNotificationsCount();
}
