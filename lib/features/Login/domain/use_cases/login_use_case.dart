import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/Login/domain/entities/login_data.dart';
import 'package:madaresco/features/Login/domain/repositories/login_repository.dart';

class LoginUseCase {
  final LoginRepo _repo;

  LoginUseCase(this._repo);
  Future<Either<Failure, LoginData>> call(String userCode, String password,
      String schoolCode, String email, String type) async {
    return await _repo.login(userCode, password, schoolCode, email, type);
  }
}
