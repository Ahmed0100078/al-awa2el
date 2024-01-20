import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:madaresco/Util/Event.dart';
import 'package:madaresco/core/constant.dart';
import 'package:madaresco/features/Login/presentation/manager/LoginViewModel.dart';
import 'package:madaresco/features/Main/domain/entities/MainEntity.dart';
import 'package:madaresco/features/Main/domain/use_cases/get_NotificationCount.dart';
import 'package:madaresco/features/Main/domain/use_cases/get_main_notifications.dart';
import 'package:madaresco/features/Main/domain/use_cases/get_student_data_use_case.dart';

class MainViewModel extends ChangeNotifier {
  ValueNotifier<bool> _loading = ValueNotifier(false);

  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<Event<String>> _toast = ValueNotifier(Event(''));

  ValueNotifier<Event<String>> get toast => _toast;
  MainEntity _entity = MainEntity(
      name: '', avatar: '', school: '', section: '', grade: '', stage: '',appearResults: 0);

  MainEntity get entity => _entity;
  int notificationsCount = 0;

  final GetStudentDataUseCase _studentDataUseCase;
  final GetMainNotifications _mainNotifications;
  final GetMainNotificationsCount _getNotificationsCount;

  MainViewModel(
      {required GetStudentDataUseCase studentDataUseCase,
      required GetMainNotifications mainNotifications,
      required GetMainNotificationsCount getNotificationsCount})
      : _studentDataUseCase = studentDataUseCase,
        _mainNotifications = mainNotifications,
        _getNotificationsCount = getNotificationsCount {
    getData();
  }

  void getData() async {
    _loading.value = true;
    final failureOrInfo = await _studentDataUseCase();
    failureOrInfo.fold((l) => _toast.value = Event(SERVER_FAILURE_MESSAGE),
        (r) {
      _entity = r;
      notifyListeners();
    });
    getNotifications();
  }

  void getNotifications() async {
    final failureOrNotifications = await _mainNotifications();
    failureOrNotifications
        .fold((l) => _toast.value = Event(SERVER_FAILURE_MESSAGE), (r) {
      notEntity.value = r;
    });

    final failureOrNotificationsCount = await _getNotificationsCount();
    log('failureOrNotificationsCount.  $failureOrNotificationsCount');
    failureOrNotificationsCount
        .fold((l) => _toast.value = Event(SERVER_FAILURE_MESSAGE), (r) {
      notificationsCount = r.count!;
    });

    _loading.value = false;
    notifyListeners();
  }
}
