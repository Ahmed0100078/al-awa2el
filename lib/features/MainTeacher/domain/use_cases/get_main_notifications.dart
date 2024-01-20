import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/Main/domain/entities/NotEntity.dart';
import 'package:madaresco/features/Main/domain/repositories/main_repo.dart';

class GetMainNotifications {
  MainRepo _repo;

  GetMainNotifications({
    required MainRepo repo,
  }) : _repo = repo;

  Future<Either<Failure, NotEntity>> call() async {
    return await _repo.getNotifications();
  }
}
