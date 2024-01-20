import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/SchoolNewsDetails/domain/entities/school_news_details_entity.dart';

abstract class SchoolNewsDetailsRepo {
  Future<Either<Failure, SchoolNewsDetailsEntity>> getSchoolNewsDetails(int id);
}
