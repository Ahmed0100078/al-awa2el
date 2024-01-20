import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/StudentBehavior/domain/entities/student_behavior_entity.dart';

abstract class StudentBehaviorRepo {
  Future<Either<Failure, StudentBehaviorEntity>> getBehavior();
}
