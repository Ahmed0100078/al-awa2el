import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/TeacherRooms/domain/entities/teacher_rooms_entity.dart';
import 'package:madaresco/features/TeacherRooms/domain/repositories/teacher_rooms_repo.dart';

class GetTeacherRoomsUseCase {
  TeacherRoomsRepo _repo;

  GetTeacherRoomsUseCase({
    required TeacherRoomsRepo repo,
  }) : _repo = repo;

  Future<Either<Failure, TeacherRoomsEntity>> call([int page = 1]) async {
    return await _repo.getAllRooms(page);
  }
}
