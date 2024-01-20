import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/SchoolNews/data/data_sources/school_news_remote_data_source.dart';
import 'package:madaresco/features/SchoolNews/domain/entities/school_news_entity.dart';
import 'package:madaresco/features/SchoolNews/domain/repositories/school_news_repo.dart';

class SchoolNewsRepoImpl implements SchoolNewsRepo {
  SchoolNewsRemoteDataSource _remoteDataSource;

  SchoolNewsRepoImpl({
    required SchoolNewsRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, SchoolNewsEntity>> getNews([int page = 1]) async {
    try {
      final schoolNews = await _remoteDataSource.getNews(page);
      return Right(schoolNews);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
