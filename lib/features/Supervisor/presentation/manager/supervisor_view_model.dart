import 'package:flutter/material.dart';
import 'package:madaresco/Util/Event.dart';
import 'package:madaresco/features/Login/presentation/manager/LoginViewModel.dart';
import 'package:madaresco/features/Main/domain/use_cases/get_main_notifications.dart';
import 'package:madaresco/features/Supervisor/domain/entities/supervisor_entity.dart';
import 'package:madaresco/features/Supervisor/domain/use_cases/get_supervisor_data_use_case.dart';

class SupervisorViewModel extends ChangeNotifier {
  ValueNotifier<bool> _loading = ValueNotifier(false);

  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<Event<String>> _toast = ValueNotifier(Event(''));

  ValueNotifier<Event<String>> get toast => _toast;
  SupervisorEntity _entity =
      SupervisorEntity(name: '', avatar: '', school: '', subject: '');

  SupervisorEntity get entity => _entity;

  final GetSupervisorDataUseCase _supervisoDataUseCase;
  final GetMainNotifications _mainNotifications;

  SupervisorViewModel({
    required GetSupervisorDataUseCase supervisoDataUseCase,
    required GetMainNotifications mainNotifications,
  })  : _supervisoDataUseCase = supervisoDataUseCase,
        _mainNotifications = mainNotifications {
    getData();
  }

  void getData() async {
    _loading.value = true;
    final failureOrInfo = await _supervisoDataUseCase();
    failureOrInfo.fold((l) => _toast.value = Event(SERVER_FAILURE_MESSAGE),
        (r) {
      _entity = r;
      notifyListeners();
    });
    await _mainNotifications();
    _loading.value = false;
  }
}
