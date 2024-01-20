import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/AllLessons/domain/entities/all_lessons_entity.dart';
import 'package:madaresco/features/AllLessons/domain/repositories/all_lessons_repo.dart';

class GetLessonsUseCase {
  AllLessonsRepo _repo;

  GetLessonsUseCase({
    required AllLessonsRepo repo,
  }) : _repo = repo;

  Future<Either<Failure, AllLessonsEntity>> call(int id, [int page = 1]) async {
    return await _repo.getLessons(id, page);
  }
}
