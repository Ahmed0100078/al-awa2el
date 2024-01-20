import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/AddOnlineLesson/domain/entities/add_online_lesson_entity.dart';
import 'package:madaresco/features/AddOnlineLesson/domain/repositories/add_online_lesson_repo.dart';

class AddOnlineLessonUseCase {
  final AddOnlineLessonRepo _repo;

  const AddOnlineLessonUseCase({
    required AddOnlineLessonRepo repo,
  }) : _repo = repo;

  Future<Either<Failure, bool>> call(AddOnlineLessonEntity entity) async {
    return await _repo.addLesson(entity);
  }
}
