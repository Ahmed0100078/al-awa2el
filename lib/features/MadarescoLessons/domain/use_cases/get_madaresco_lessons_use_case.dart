import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/MadarescoLessons/domain/entities/madaresco_lessons_entitiy.dart';
import 'package:madaresco/features/MadarescoLessons/domain/repositories/madaresco_lessons_repo.dart';

class GetMadarescoLessonsUseCase {
  MadarescoLessonsRepo _repo;

  GetMadarescoLessonsUseCase({
    required MadarescoLessonsRepo repo,
  }) : _repo = repo;

  Future<Either<Failure, MadarescoLessonsEntity>> call(
      [int? stageId, int? gradeId, String? term, int page = 1]) async {
    return await _repo.getMadarescoLessons(stageId!, gradeId!, term!, page);
  }
}
