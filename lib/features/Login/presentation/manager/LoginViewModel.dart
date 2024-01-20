import 'package:flutter/cupertino.dart';
import 'package:madaresco/Util/Event.dart';
import 'package:madaresco/features/Login/domain/use_cases/login_use_case.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class LoginViewModel extends ChangeNotifier {
  ValueNotifier<bool> _loading = ValueNotifier(false);

  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<Event<String>> _toast = ValueNotifier(Event(''));

  ValueNotifier<Event<String>> get toast => _toast;

  ValueNotifier<Event<String>> _navigateTo = ValueNotifier(Event(''));

  ValueNotifier<Event<String>> get navigateTo => _navigateTo;
  String? _usercode, _password, _schoolCode, _email = '', _type = 'Main';
  set userCode(String uCode) => _usercode = uCode;
  set password(String pass) => _password = pass;
  set schoolCode(String sCode) => _schoolCode = sCode;
  set email(String mail) => _email = mail;
  set type(String type) => _type = type;
  final LoginUseCase _loginUseCase;

  LoginViewModel({
    required LoginUseCase loginUseCase,
  }) :
        // assert(loginUseCase != null),
        _loginUseCase = loginUseCase;

  void onLoginClicked() async {
    _loading.value = true;
    var failureOrdLoginData = await _loginUseCase(
        _usercode ?? "", _password!, _schoolCode ?? "", _email!, _type!);
    failureOrdLoginData.fold((failure) {
      _toast.value = Event(SERVER_FAILURE_MESSAGE);
    }, (loginData) {
      if (loginData.isActive!) {
        if (loginData.type == 'teacher') {
          _navigateTo.value = Event('MainTeacher');
        } else if (loginData.type == 'supervisor') {
          _navigateTo.value = Event('FatherPage');
        } else {
          _navigateTo.value = Event('Main');
        }
      } else {
        _navigateTo.value = Event('success');
      }
    });
    _loading.value = false;
  }
}
