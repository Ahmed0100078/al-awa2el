import 'package:flutter/material.dart';
import 'package:madaresco/Util/Event.dart';
import 'package:madaresco/features/Login/presentation/manager/LoginViewModel.dart';
import 'package:madaresco/features/Notifications/domain/entities/notification_entity.dart';
import 'package:madaresco/features/Notifications/domain/use_cases/get_notifications_use_case.dart';

class NotificationsViewModel extends ChangeNotifier {
  ValueNotifier<bool> _loading = ValueNotifier(false);

  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<Event<String>> _toast = ValueNotifier(Event(''));

  ValueNotifier<Event<String>> get toast => _toast;

  NotificationsEntity _entity = NotificationsEntity(notifications: []);

  NotificationsEntity get entity => _entity;
  GetNotificationsUseCase _notificationsUseCase;

  NotificationsViewModel({
    required GetNotificationsUseCase notificationsUseCase,
  }) : _notificationsUseCase = notificationsUseCase {
    getNotifications();
  }

  void getNotifications() async {
    _loading.value = true;
    final failureOrNotifications = await _notificationsUseCase();
    failureOrNotifications
        .fold((l) => _toast.value = Event(SERVER_FAILURE_MESSAGE), (r) {
      _entity = r;
      notifyListeners();
    });
    _loading.value = false;
  }
}
