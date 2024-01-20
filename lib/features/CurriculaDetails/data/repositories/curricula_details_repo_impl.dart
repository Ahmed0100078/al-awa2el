import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/CurriculaDetails/data/data_sources/curricula_details_remote_data_source.dart';
import 'package:madaresco/features/CurriculaDetails/domain/entities/curricula_details_entity.dart';
import 'package:madaresco/features/CurriculaDetails/domain/repositories/curricula_details_repo.dart';

class CurriculaDetailsRepoImpl implements CurriculaDetailsRepo {
  final CurriculaDetailsRemoteDataSource _remoteDataSource;

  const CurriculaDetailsRepoImpl({
    required CurriculaDetailsRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, CurriculaDetailsEntity>> getCurriculaDetails(
      int id) async {
    try {
      return Right(await _remoteDataSource.getCurriculaDetails(id));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
