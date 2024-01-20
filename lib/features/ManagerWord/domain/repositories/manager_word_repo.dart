import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/ManagerWord/domain/entities/manager_word_entity.dart';

abstract class ManagerWordRepo {
  Future<Either<Failure, ManagerWordEntity>> getManagerWord();
}
