import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/MadarescoLessonDetails/domain/entities/madaresco_lesson_details_entity.dart';
import 'package:madaresco/features/MadarescoLessonDetails/domain/repositories/madaresco_lesson_details_repo.dart';

class GetMadarescoLessonDetailsUseCase {
  MadarescoLessonDetailsRepo _repo;

  GetMadarescoLessonDetailsUseCase({
    required MadarescoLessonDetailsRepo repo,
  }) : _repo = repo;

  Future<Either<Failure, MadarescoLessonDetailsEntity>> call(int id) async {
    return await _repo.getLessonDetails(id);
  }
}
