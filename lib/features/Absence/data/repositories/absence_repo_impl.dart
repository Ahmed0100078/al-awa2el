import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/Absence/data/data_sources/absence_remote_data_source.dart';
import 'package:madaresco/features/Absence/domain/entities/absence_entity.dart';
import 'package:madaresco/features/Absence/domain/repositories/absence_repo.dart';

class AbsenceRepoImpl implements AbsenceRepo {
  AbsenceRemoteDataSource _remoteDataSource;

  AbsenceRepoImpl({
    required AbsenceRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, AbsenceEntity>> getAbsence([String ?date]) async {
    try {
      final absences = await _remoteDataSource.getAbsence(date!);
      return Right(absences);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
