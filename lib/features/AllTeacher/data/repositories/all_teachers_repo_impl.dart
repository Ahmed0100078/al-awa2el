import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/AllTeacher/data/data_sources/all_teachers_data_source.dart';
import 'package:madaresco/features/AllTeacher/domain/entities/all_teachers_entity.dart';
import 'package:madaresco/features/AllTeacher/domain/repositories/all_teachers_repo.dart';

class AllTeachersRepoImpl implements AllTeachersRepo {
  AllTeachersRemoteDataSource _remoteDataSource;

  AllTeachersRepoImpl({
    required AllTeachersRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, AllTeachersEntity>> getAllTeachers(
      [int page = 1]) async {
    try {
      return Right(await _remoteDataSource.getAllTeachers(page));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
