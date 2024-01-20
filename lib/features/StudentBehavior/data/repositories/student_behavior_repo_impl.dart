import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/StudentBehavior/data/datasources/student_behavior_remote_data_source.dart';
import 'package:madaresco/features/StudentBehavior/domain/entities/student_behavior_entity.dart';
import 'package:madaresco/features/StudentBehavior/domain/repositories/student_behavior_repo.dart';

class StudentBehaviorRepoImpl implements StudentBehaviorRepo {
  StudentBehaviorRemoteDataSource _remoteDataSource;
  StudentBehaviorRepoImpl(
      {required StudentBehaviorRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, StudentBehaviorEntity>> getBehavior() async {
    try {
      final behavior = await _remoteDataSource.getStudentBehavior();
      final result = StudentBehaviorEntity(
        status: behavior.data!.about ?? "",
        name: behavior.data!.name ?? "",
        grade: behavior.data!.section!.grade!.name ?? "",
        avatar: behavior.data!.avatar ?? "",
        warningsList: behavior.data!.warnings!
            .map(
              (e) => Warning(date: e.date ?? "", title: e.reason ?? ""),
            )
            .toList(),
      );
      return Right(result);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
