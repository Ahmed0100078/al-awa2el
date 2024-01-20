import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/GallaryDetails/domain/entities/gallary_details_entities.dart';

abstract class GallaryDetailsRepo {
  Future<Either<Failure, GallaryDetailsEntity>> getGallaryDetails(int id);
}
