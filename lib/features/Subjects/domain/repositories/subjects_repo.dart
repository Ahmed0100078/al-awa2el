import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/Subjects/domain/entities/subject_entity.dart';

abstract class SubjectsRepo {
  Future<Either<Failure, SubjectEntity>> getSubjects();
}
