import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/ManagerWord/data/data_sources/manager_word_remote_data_source.dart';
import 'package:madaresco/features/ManagerWord/domain/entities/manager_word_entity.dart';
import 'package:madaresco/features/ManagerWord/domain/repositories/manager_word_repo.dart';

class ManagerWordRepoImpl implements ManagerWordRepo {
  ManagerWordRemoteDataSource _remoteDataSource;

  ManagerWordRepoImpl({
    required ManagerWordRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, ManagerWordEntity>> getManagerWord() async {
    try {
      final mangerWord = await _remoteDataSource.getManagerWord();
      return Right(mangerWord);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
