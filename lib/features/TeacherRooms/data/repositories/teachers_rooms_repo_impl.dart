import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/TeacherRooms/data/data_sources/teachers_rooms_data_source.dart';
import 'package:madaresco/features/TeacherRooms/domain/entities/teacher_rooms_entity.dart';
import 'package:madaresco/features/TeacherRooms/domain/repositories/teacher_rooms_repo.dart';

class TeacherRoomsRepoImpl implements TeacherRoomsRepo {
  TeachersRoomsRemoteDataSource _remoteDataSource;

  TeacherRoomsRepoImpl({
    required TeachersRoomsRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, TeacherRoomsEntity>> getAllRooms(
      [int page = 1]) async {
    try {
      return Right(await _remoteDataSource.getTeachersRooms(page));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
