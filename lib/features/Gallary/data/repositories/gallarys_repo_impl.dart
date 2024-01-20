import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/Gallary/data/data_sources/gallarys_remote_data_source.dart';
import 'package:madaresco/features/Gallary/domain/entities/gallary_entity.dart';
import 'package:madaresco/features/Gallary/domain/repositories/gallary_repo.dart';

class GallarysRepoImpl implements GallaryRepo {
  GallarysRemoteDataSource _remoteDataSource;

  GallarysRepoImpl({
    required GallarysRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, GallaryEntity>> getGallarys([int page = 1]) async {
    try {
      final gallarys = await _remoteDataSource.getGallarys();
      return Right(gallarys);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
