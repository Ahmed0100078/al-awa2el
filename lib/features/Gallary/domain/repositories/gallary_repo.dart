import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/Gallary/domain/entities/gallary_entity.dart';

abstract class GallaryRepo {
  Future<Either<Failure, GallaryEntity>> getGallarys([int page = 1]);
}
