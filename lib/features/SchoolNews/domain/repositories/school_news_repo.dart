import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/SchoolNews/domain/entities/school_news_entity.dart';

abstract class SchoolNewsRepo {
  Future<Either<Failure, SchoolNewsEntity>> getNews([int page = 1]);
}
