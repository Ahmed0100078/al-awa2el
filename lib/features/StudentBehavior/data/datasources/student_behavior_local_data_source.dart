import 'package:madaresco/Util/SharedPrefernce.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/features/Login/data/remote/models/login_model.dart';

abstract class StudentBehaviorLocalDataSource {
  /// Throws [CacheException]
  Future<LoginModel?> getStudentBehavior();
}

class StudentBehaviorLocalDataSourceImpl
    implements StudentBehaviorLocalDataSource {
  @override
  Future<LoginModel?> getStudentBehavior() async {
    try {
      return await SharedPreference.getLoginModel();
    } catch (e) {
      throw (CacheException());
    }
  }
}
