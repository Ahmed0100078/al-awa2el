import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/Subjects/domain/entities/subject_entity.dart';
import 'package:madaresco/features/Subjects/domain/repositories/subjects_repo.dart';

class GetSubjectsUseCase {
  SubjectsRepo _repo;

  GetSubjectsUseCase({
    required SubjectsRepo repo,
  }) : _repo = repo;

  Future<Either<Failure, SubjectEntity>> call() async {
    return await _repo.getSubjects();
  }
}
