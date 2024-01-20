import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/Annual/domain/entities/annual_entity.dart';

abstract class AnnualRepo {
  Future<Either<Failure, AnnualEntity>> getAnnuals();
}
