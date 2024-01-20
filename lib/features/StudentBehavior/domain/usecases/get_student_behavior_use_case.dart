import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/StudentBehavior/domain/entities/student_behavior_entity.dart';
import 'package:madaresco/features/StudentBehavior/domain/repositories/student_behavior_repo.dart';

class GetStudentBehaviorUseCase {
  StudentBehaviorRepo _repo;
  GetStudentBehaviorUseCase({required StudentBehaviorRepo repo}) : _repo = repo;

  Future<Either<Failure, StudentBehaviorEntity>> call() async {
    return await _repo.getBehavior();
  }
}
