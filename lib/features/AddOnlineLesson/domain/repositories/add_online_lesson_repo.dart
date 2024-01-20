import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/AddOnlineLesson/domain/entities/add_online_lesson_entity.dart';
import 'package:madaresco/features/AddOnlineLesson/domain/entities/students_entity.dart';
import 'package:madaresco/features/Register/domain/entities/item_entity.dart';

abstract class AddOnlineLessonRepo {
  Future<Either<Failure, StudentsEntity>> getStudents(int sectionId/*,[int page = 1]*/);
  Future<Either<Failure, bool>> addLesson(AddOnlineLessonEntity addOnlineLessonEntity);
  Future<Either<Failure, ItemsEntity>> getStages();
}