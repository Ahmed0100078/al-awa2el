import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/Absence/domain/entities/absence_entity.dart';

abstract class AbsenceRepo {
  Future<Either<Failure, AbsenceEntity>> getAbsence([String date]);
}
