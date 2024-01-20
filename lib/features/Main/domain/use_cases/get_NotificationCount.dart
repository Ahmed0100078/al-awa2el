import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/Main/domain/repositories/main_repo.dart';
import 'package:madaresco/features/Notifications/data/models/notifications_model.dart';

class GetMainNotificationsCount {
  MainRepo _repo;

  GetMainNotificationsCount({
    required MainRepo repo,
  }) : _repo = repo;

  Future<Either<Failure, NotificationsModel>> call() async {
    return await _repo.getNotificationsCount();
  }
}
