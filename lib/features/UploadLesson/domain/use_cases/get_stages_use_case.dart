import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/Register/domain/entities/item_entity.dart';
import 'package:madaresco/features/UploadLesson/domain/repositories/upload_lesson_repo.dart';

class GetStagesUseCase {
  UploadLessonRepo _repo;

  GetStagesUseCase({
    required UploadLessonRepo repo,
  }) : _repo = repo;

  Future<Either<Failure, ItemsEntity>> call() async {
    return await _repo.getStages();
  }
}
