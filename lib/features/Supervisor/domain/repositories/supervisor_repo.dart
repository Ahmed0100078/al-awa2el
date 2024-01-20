import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/Main/domain/entities/NotEntity.dart';
import 'package:madaresco/features/Supervisor/domain/entities/supervisor_entity.dart';

abstract class SupervisorRepo {
  Future<Either<Failure, SupervisorEntity>> getUserInfo();
  Future<Either<Failure, NotEntity>> getNotifications();
}
