import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/GallaryDetails/domain/entities/gallary_details_entities.dart';
import 'package:madaresco/features/GallaryDetails/domain/repositories/gallary_details_repo.dart';

class GetGallaryDetailsUseCase {
  GallaryDetailsRepo _repo;

  GetGallaryDetailsUseCase({
    required GallaryDetailsRepo repo,
  }) : _repo = repo;

  Future<Either<Failure, GallaryDetailsEntity>> call(int id) async {
    return await _repo.getGallaryDetails(id);
  }
}
