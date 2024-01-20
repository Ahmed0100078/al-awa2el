import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/AboutApp/data/data_sources/about_app_remote_data_source.dart';
import 'package:madaresco/features/AboutApp/domain/entities/about_app_entity.dart';
import 'package:madaresco/features/AboutApp/domain/repositories/about_app_repo.dart';

class AboutAppRepoImpl implements AboutAppRepo {
  AboutAppRemoteDataSource _remoteDataSource;

  AboutAppRepoImpl({
    required AboutAppRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, AboutAppEntity>> getAboutApp() async {
    try {
      final aboutApp = await _remoteDataSource.getAboutApp();
      return Right(aboutApp);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
