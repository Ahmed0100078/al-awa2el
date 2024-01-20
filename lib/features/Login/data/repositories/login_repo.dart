import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/Login/data/local/data_sources/login_local_datasource.dart';
import 'package:madaresco/features/Login/data/remote/data_sources/login_remote_datasource.dart';
import 'package:madaresco/features/Login/domain/entities/login_data.dart';
import 'package:madaresco/features/Login/domain/repositories/login_repository.dart';

class LoginRepoImpl implements LoginRepo {
  LoginLocalDataSource localDataSource;
  LoginRemoteDataSource remoteDataSource;

  LoginRepoImpl(
      {required this.localDataSource, required this.remoteDataSource});

  @override
  Future<Either<Failure, LoginData>> login(String userCode, String password,
      String schoolCode, String email, String type) async {
    try {
      final loginData = await remoteDataSource.login(
          userCode, password, schoolCode, email, type);
      try {
        localDataSource.saveUserData(loginData);
        return Right(loginData);
      } on CacheException {
        return Left(CacheFailure());
      }
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
