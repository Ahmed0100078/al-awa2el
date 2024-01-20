import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/Main/domain/entities/NotEntity.dart';
import 'package:madaresco/features/MainTeacher/domain/entities/main_teacher_entity.dart';

abstract class MainTeacherRepo {
  Future<Either<Failure, MainTeacherEntity>> getUserInfo();
  Future<Either<Failure, NotEntity>> getNotifications();
}
