import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/MadarescoLessonDetails/data/data_sources/madaresco_lesson_remote_datasource.dart';
import 'package:madaresco/features/MadarescoLessonDetails/domain/entities/madaresco_lesson_details_entity.dart';
import 'package:madaresco/features/MadarescoLessonDetails/domain/repositories/madaresco_lesson_details_repo.dart';

class MadarescoLessonDetailsRepoImpl implements MadarescoLessonDetailsRepo {
  final MadarescoLessonDetailsRemoteDataSource _remoteDataSource;

  const MadarescoLessonDetailsRepoImpl({
    required MadarescoLessonDetailsRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, MadarescoLessonDetailsEntity>> getLessonDetails(
      int id) async {
    try {
      return Right(await _remoteDataSource.getLessonDetails(id));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
