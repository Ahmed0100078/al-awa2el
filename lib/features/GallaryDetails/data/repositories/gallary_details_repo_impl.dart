import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/GallaryDetails/data/data_sources/gallary_details_remote_data_source.dart';
import 'package:madaresco/features/GallaryDetails/domain/entities/gallary_details_entities.dart';
import 'package:madaresco/features/GallaryDetails/domain/repositories/gallary_details_repo.dart';

class GallaryDetailsRepoImpl implements GallaryDetailsRepo {
  GallaryDetailsRemoteDataSource _remoteDataSource;

  GallaryDetailsRepoImpl({
    required GallaryDetailsRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, GallaryDetailsEntity>> getGallaryDetails(
      int id) async {
    try {
      final gallaryDetails = await _remoteDataSource.getGallaryDetails(id);
      return Right(gallaryDetails);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
