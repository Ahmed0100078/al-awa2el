import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/Gallary/domain/entities/gallary_entity.dart';
import 'package:madaresco/features/Gallary/domain/repositories/gallary_repo.dart';

class GetGallarysUseCase {
  GallaryRepo _repo;

  GetGallarysUseCase({
    required GallaryRepo repo,
  }) : _repo = repo;

  Future<Either<Failure, GallaryEntity>> call([int page = 1]) async {
    return await _repo.getGallarys(page);
  }
}
