import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/MyProfile/domain/entities/my_profile_entity.dart';
import 'package:madaresco/features/MyProfile/domain/repositories/my_profile_repo.dart';

class GetMyProfileUseCase {
  MyProfileRepo _repo;

  GetMyProfileUseCase({
    required MyProfileRepo repo,
  }) : _repo = repo;

  Future<Either<Failure, MyProfileEntity>> call() async {
    return await _repo.getMyProfile();
  }
}
