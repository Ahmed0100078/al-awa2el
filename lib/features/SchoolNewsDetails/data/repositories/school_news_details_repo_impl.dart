import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/SchoolNewsDetails/data/data_sources/school_news_details_remote_data_source.dart';
import 'package:madaresco/features/SchoolNewsDetails/domain/entities/school_news_details_entity.dart';
import 'package:madaresco/features/SchoolNewsDetails/domain/repositories/school_news_details_repo.dart';

class SchoolNewsDetailsRepoImpl implements SchoolNewsDetailsRepo {
  SchoolNewsDetailsRemoteDataSource _remoteDataSource;

  SchoolNewsDetailsRepoImpl({
    required SchoolNewsDetailsRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, SchoolNewsDetailsEntity>> getSchoolNewsDetails(
      int id) async {
    try {
      return Right(await _remoteDataSource.getSchoolNewsDetails(id));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
