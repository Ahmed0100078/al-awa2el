import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/MadarescoLessonDetails/domain/entities/madaresco_lesson_details_entity.dart';

abstract class MadarescoLessonDetailsRepo {
  Future<Either<Failure, MadarescoLessonDetailsEntity>> getLessonDetails(int id);
}
