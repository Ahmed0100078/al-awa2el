import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/Subjects/data/data_sources/subjects_remote_data_source.dart';
import 'package:madaresco/features/Subjects/domain/entities/subject_entity.dart';
import 'package:madaresco/features/Subjects/domain/repositories/subjects_repo.dart';

class SubjectsRepoImpl implements SubjectsRepo {
  SubjectsRemoteDataSource _remoteDataSource;

  SubjectsRepoImpl({
    required SubjectsRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, SubjectEntity>> getSubjects() async {
    try {
      final subjects = await _remoteDataSource.getSubjects();
      return Right(subjects);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
