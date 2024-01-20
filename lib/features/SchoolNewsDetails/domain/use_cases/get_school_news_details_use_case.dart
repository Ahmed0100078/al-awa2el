import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/SchoolNewsDetails/domain/entities/school_news_details_entity.dart';
import 'package:madaresco/features/SchoolNewsDetails/domain/repositories/school_news_details_repo.dart';

class GetSchoolNewsEntityUseCase {
  SchoolNewsDetailsRepo _repo;

  GetSchoolNewsEntityUseCase({
    required SchoolNewsDetailsRepo repo,
  }) : _repo = repo;

  Future<Either<Failure, SchoolNewsDetailsEntity>> call(int id) async {
    return await _repo.getSchoolNewsDetails(id);
  }
}
