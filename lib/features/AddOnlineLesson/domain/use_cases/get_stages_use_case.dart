import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/AddOnlineLesson/domain/repositories/add_online_lesson_repo.dart';
import 'package:madaresco/features/Register/domain/entities/item_entity.dart';

class GetStagesUseCase {
  final AddOnlineLessonRepo _repo;

  const GetStagesUseCase({
    required AddOnlineLessonRepo repo,
  }) : _repo = repo;

  Future<Either<Failure, ItemsEntity>> call() async {
    return await _repo.getStages();
  }
}
