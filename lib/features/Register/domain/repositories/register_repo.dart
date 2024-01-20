import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/Register/domain/entities/item_entity.dart';
import 'package:madaresco/features/Register/domain/entities/register_entity.dart';
import 'package:madaresco/features/Register/domain/entities/send_entity.dart';

abstract class RegisterRepo {
  Future<Either<Failure, RegisterEntity>> registerTeacher(SendEntity sendEntity);

  Future<Either<Failure, RegisterEntity>> registerStudent(SendEntity sendEntity);

  Future<Either<Failure, Item>> registerSchool(SendEntity sendEntity);

  Future<Either<Failure, ItemsEntity>> getSchools();
  Future<Either<Failure, ItemsEntity>> getStages(int schoolId);
  Future<Either<Failure, ItemsEntity>> getGrades(int stageId);
  Future<Either<Failure, ItemsEntity>> getSections(int gradeId);
}
