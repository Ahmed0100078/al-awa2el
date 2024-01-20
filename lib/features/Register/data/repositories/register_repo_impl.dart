import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/Register/data/data_sources/register_remote_data_source.dart';
import 'package:madaresco/features/Register/domain/entities/item_entity.dart';
import 'package:madaresco/features/Register/domain/entities/register_entity.dart';
import 'package:madaresco/features/Register/domain/entities/send_entity.dart';
import 'package:madaresco/features/Register/domain/repositories/register_repo.dart';
class RegisterRepoImpl implements RegisterRepo {
  RegisterRemoteDataSource _remoteDataSource;

  RegisterRepoImpl({
    required RegisterRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, Item>> registerSchool(SendEntity sendEntity) async {
    try {
      return Right(await _remoteDataSource.registerSchool(sendEntity));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, RegisterEntity>> registerStudent(
      SendEntity sendEntity) async {
    try {
      return Right(await _remoteDataSource.registerStudent(sendEntity));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, RegisterEntity>> registerTeacher(
      SendEntity sendEntity) async {
    try {
      return Right(await _remoteDataSource.registerTeacher(sendEntity));
    } on ServerException catch (e) {
      return Left(ServerFailure(errMSg: e.errMsg));
    }
  }

  @override
  Future<Either<Failure, ItemsEntity>> getGrades(int stageId) async {
    try {
      return Right(await _remoteDataSource.getGrades(stageId));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, ItemsEntity>> getSchools() async {
    try {
      return Right(await _remoteDataSource.getSchools());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, ItemsEntity>> getSections(int gradeId) async {
    try {
      return Right(await _remoteDataSource.getSections(gradeId));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, ItemsEntity>> getStages(int schoolId) async {
    try {
      return Right(await _remoteDataSource.getStages(schoolId));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
