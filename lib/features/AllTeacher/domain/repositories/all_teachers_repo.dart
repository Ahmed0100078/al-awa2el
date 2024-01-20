import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/AllTeacher/domain/entities/all_teachers_entity.dart';

abstract class AllTeachersRepo {
  Future<Either<Failure, AllTeachersEntity>> getAllTeachers([int page = 1]);
}
