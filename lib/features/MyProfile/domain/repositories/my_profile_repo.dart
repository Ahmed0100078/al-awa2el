import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/MyProfile/domain/entities/edit_profile_entity.dart';
import 'package:madaresco/features/MyProfile/domain/entities/my_profile_entity.dart';

abstract class MyProfileRepo {
  Future<Either<Failure, MyProfileEntity>> getMyProfile();
  Future<Either<Failure, MyProfileEntity>> editProfile(EditProfileEntity entity);
}
