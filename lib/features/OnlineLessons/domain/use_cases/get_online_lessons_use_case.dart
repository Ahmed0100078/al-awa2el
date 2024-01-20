import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/OnlineLessons/domain/entities/online_lessons_entity.dart';
import 'package:madaresco/features/OnlineLessons/domain/repositories/online_lesson_repo.dart';

class GetOnlineLessonsUseCase {
  final OnlineLessonRepo _repo;

  const GetOnlineLessonsUseCase({
    required OnlineLessonRepo repo,
  }) : _repo = repo;

  Future<Either<Failure, OnlineLessonsEntity>> call([int page = 1]) async {
    return await _repo.getLessons(page);
  }
}
