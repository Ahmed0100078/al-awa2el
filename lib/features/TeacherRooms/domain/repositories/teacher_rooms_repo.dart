import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/TeacherRooms/domain/entities/teacher_rooms_entity.dart';

abstract class TeacherRoomsRepo {
  Future<Either<Failure, TeacherRoomsEntity>> getAllRooms([int page = 1]);
}
