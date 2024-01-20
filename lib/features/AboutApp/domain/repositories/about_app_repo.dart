import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/AboutApp/domain/entities/about_app_entity.dart';

abstract class AboutAppRepo {
  Future<Either<Failure, AboutAppEntity>> getAboutApp();
}
