import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/Curricula/data/data_sources/curricula_data_source.dart';
import 'package:madaresco/features/Curricula/domain/entities/curricula_entity.dart';
import 'package:madaresco/features/Curricula/domain/entities/filter_entity.dart';
import 'package:madaresco/features/Curricula/domain/repositories/curricula_repo.dart';

class CurriculaRepoImpl implements CurriculaRepo {
  CurriculaRemoteDataSource _remoteDataSource;

  CurriculaRepoImpl({
    required CurriculaRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, CurriculaEntity>> getCurricula(
      [int? stageId,
      int? gradeId,
      int? subjectId,
      String? term,
      int page = 1]) async {
    try {
      return Right(await _remoteDataSource.getCurricula(
          stageId!, gradeId!, subjectId!, term!, page));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, FilterEntity>> getGrades(int stageId) async {
    try {
      return Right(await _remoteDataSource.getGrades(stageId));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, FilterEntity>> getStages() async {
    try {
      return Right(await _remoteDataSource.getStages());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, FilterEntity>> getSubjects(int gradeId) async {
    try {
      return Right(await _remoteDataSource.getSubjects(gradeId));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
