import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/SchoolNews/domain/entities/school_news_entity.dart';
import 'package:madaresco/features/SchoolNews/domain/repositories/school_news_repo.dart';

class GetSchoolNewsUseCase {
  SchoolNewsRepo _repo;

  GetSchoolNewsUseCase({
    required SchoolNewsRepo repo,
  }) : _repo = repo;

  Future<Either<Failure, SchoolNewsEntity>> call([int page = 1]) async {
    return await _repo.getNews(page);
  }
}
