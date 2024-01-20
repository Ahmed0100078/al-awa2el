import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/MyProfile/data/data_sources/my_profile_remote_data_source.dart';
import 'package:madaresco/features/MyProfile/domain/entities/edit_profile_entity.dart';
import 'package:madaresco/features/MyProfile/domain/entities/my_profile_entity.dart';
import 'package:madaresco/features/MyProfile/domain/repositories/my_profile_repo.dart';

class MyProfileRepoImpl implements MyProfileRepo {
  MyProfileRemoteDataSource _remoteDataSource;

  MyProfileRepoImpl({
    required MyProfileRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, MyProfileEntity>> getMyProfile() async {
    try {
      return Right(await _remoteDataSource.getProfile());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, MyProfileEntity>> editProfile(
      EditProfileEntity entity) async {
    try {
      return Right(await _remoteDataSource.editProfile(entity));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
