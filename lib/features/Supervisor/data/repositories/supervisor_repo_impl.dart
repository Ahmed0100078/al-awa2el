import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/Main/domain/entities/NotEntity.dart';
import 'package:madaresco/features/Supervisor/data/remote/data_sources/Supervisor_Data_Sources.dart';
import 'package:madaresco/features/Supervisor/domain/entities/supervisor_entity.dart';
import 'package:madaresco/features/Supervisor/domain/repositories/supervisor_repo.dart';

class SupervisorRepoImpl implements SupervisorRepo {
  SupervisorRemoteDataSource _remoteDataSource;

  SupervisorRepoImpl({
    required SupervisorRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, SupervisorEntity>> getUserInfo() async {
    try {
      final teacherInfo = await _remoteDataSource.getSupervisorInfo();
      return Right(teacherInfo);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, NotEntity>> getNotifications() async {
    try {
      final mainNotification = await _remoteDataSource.getMainNotifications();
      return Right(mainNotification);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
