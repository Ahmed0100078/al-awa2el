import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/Login/domain/entities/login_data.dart';

abstract class LoginRepo {
  Future<Either<Failure, LoginData>> login(String userCode, String password,
      String schoolCode, String email, String type);
}
