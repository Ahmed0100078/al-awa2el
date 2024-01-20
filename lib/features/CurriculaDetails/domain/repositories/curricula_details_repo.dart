import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/CurriculaDetails/domain/entities/curricula_details_entity.dart';

abstract class CurriculaDetailsRepo {
  Future<Either<Failure, CurriculaDetailsEntity>> getCurriculaDetails(int id);
}
