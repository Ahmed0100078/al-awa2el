import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/MadarescoLessons/data/data_sources/madaresco_lessons_remote_data_source.dart';
import 'package:madaresco/features/MadarescoLessons/domain/entities/madaresco_lessons_entitiy.dart';
import 'package:madaresco/features/MadarescoLessons/domain/repositories/madaresco_lessons_repo.dart';

class MadarescoLessonsRepoImpl implements MadarescoLessonsRepo {
  MadarescoLessonsRemoteDataSource _remoteDataSource;

  MadarescoLessonsRepoImpl({
    required MadarescoLessonsRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, MadarescoLessonsEntity>> getMadarescoLessons(
      [int? stageId, int? gradeId, String? term, int page = 1]) async {
    try {
      return Right(await _remoteDataSource.getMadarescoLessons(
          stageId!, gradeId!, term!, page));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
