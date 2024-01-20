import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/AboutApp/domain/entities/about_app_entity.dart';
import 'package:madaresco/features/AboutApp/domain/repositories/about_app_repo.dart';

class GetAboutAppUseCase {
  AboutAppRepo _repo;

  GetAboutAppUseCase({
    required AboutAppRepo repo,
  }) : _repo = repo;

  Future<Either<Failure, AboutAppEntity>> call() async {
    return await _repo.getAboutApp();
  }
}
