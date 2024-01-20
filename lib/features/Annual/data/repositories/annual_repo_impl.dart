import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/Annual/data/remote/data_sources/annuals_remote_data_source.dart';
import 'package:madaresco/features/Annual/domain/entities/annual_entity.dart';
import 'package:madaresco/features/Annual/domain/repositories/annual_repo.dart';

class AnnualRepoImpl implements AnnualRepo {
  AnnualsRemoteDataSource _remoteDataSource;

  AnnualRepoImpl({
    required AnnualsRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, AnnualEntity>> getAnnuals() async {
    try {
      final annuals = await _remoteDataSource.getAnnuals();
      return Right(annuals);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
