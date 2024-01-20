import 'package:flutter/material.dart';
import 'package:madaresco/Util/Event.dart';
import 'package:madaresco/features/AboutApp/domain/entities/about_app_entity.dart';
import 'package:madaresco/features/AboutApp/domain/use_cases/get_about_app_use_case.dart';
import 'package:madaresco/features/Login/presentation/manager/LoginViewModel.dart';

class AboutAppViewModel extends ChangeNotifier {
  ValueNotifier<bool> _loading = ValueNotifier(false);

  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<Event<String>> _toast = ValueNotifier(Event(''));

  ValueNotifier<Event<String>> get toast => _toast;
  AboutAppEntity _entity = AboutAppEntity(about: '', name: 'app_name',showDeleteProfile: '',appearStudentDegrees: "");

  AboutAppEntity get entity => _entity;

  GetAboutAppUseCase _aboutAppUseCase;

  AboutAppViewModel({
    required GetAboutAppUseCase aboutAppUseCase,
  }) : _aboutAppUseCase = aboutAppUseCase {
    getAboutApp();
  }

  void getAboutApp() async {
    _loading.value = true;
    final failureOrAboutApp = await _aboutAppUseCase();
    failureOrAboutApp.fold((l) => _toast.value = Event(SERVER_FAILURE_MESSAGE),
        (r) {
      _entity = r;
      notifyListeners();
    });
    _loading.value = false;
  }
}
