import 'package:flutter/material.dart';
import 'package:madaresco/Util/Event.dart';
import 'package:madaresco/features/Login/presentation/manager/LoginViewModel.dart';
import 'package:madaresco/features/Main/domain/entities/NotEntity.dart';
import 'package:madaresco/features/Main/domain/use_cases/get_NotificationCount.dart';
import 'package:madaresco/features/Main/domain/use_cases/get_main_notifications.dart';
import 'package:madaresco/features/MainTeacher/domain/entities/main_teacher_entity.dart';
import 'package:madaresco/features/MainTeacher/domain/use_cases/get_teacher_data_use_case.dart';
import 'package:madaresco/features/Notifications/data/models/notifications_model.dart';

class MainTeacherViewModel extends ChangeNotifier {
  ValueNotifier<bool> _loading = ValueNotifier(false);

  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<Event<String>> _toast = ValueNotifier(Event(''));

  ValueNotifier<Event<String>> get toast => _toast;
  MainTeacherEntity _entity =
      MainTeacherEntity(name: '', avatar: '', school: '', subject: '');

  MainTeacherEntity get entity => _entity;
  NotEntity _notEntity = NotEntity(
      adminWordCount: '',
      attendanceCount: '0',
      lessonsCount: '0',
      newsCount: '0',
      installmentCount: '0',
      warningCount: '0',
      schoolMediaCount: '0',
      schedulesCount: '0',
      resultCount: '0',
      examsCount: '0',
      unseenRoomsCount: '0',
      unseenAdministrationConversationsCount: '0',
      onlineLessonCount: '');

  NotEntity get notEntity => _notEntity;

  final GetTeacherDataUseCase _teacherDataUseCase;
  final GetMainNotifications _mainNotifications;
  final GetMainNotificationsCount _getMainNotificationsCount;
  NotificationsModel? notificationsModel;
  int notificationCounter = 0;

  MainTeacherViewModel({
    required GetTeacherDataUseCase teacherDataUseCase,
    required GetMainNotifications mainNotifications,
    required GetMainNotificationsCount getMainNotificationsCount,
  })  : _teacherDataUseCase = teacherDataUseCase,
        _mainNotifications = mainNotifications,
        _getMainNotificationsCount = getMainNotificationsCount {
    getData();
  }

  void getData() async {
    _loading.value = true;
    final failureOrInfo = await _teacherDataUseCase();
    failureOrInfo.fold((l) => _toast.value = Event(SERVER_FAILURE_MESSAGE),
        (r) {
      _entity = r;
      notifyListeners();
    });
    final notificationCount = await _getMainNotificationsCount();
    notificationCount.fold((l) => _toast.value = Event(SERVER_FAILURE_MESSAGE),
        (r) {
      notificationsModel = r;
      notificationCounter = r.count!;
    });
    final failureOrNotifications = await _mainNotifications();
    failureOrNotifications
        .fold((l) => _toast.value = Event(SERVER_FAILURE_MESSAGE), (r) {
      _notEntity = r;
      notifyListeners();
    });
    _loading.value = false;
  }

  getNotifications() async {
    _loading.value = true;
    final notificationCount = await _getMainNotificationsCount();
    notificationCount.fold((l) => _toast.value = Event(SERVER_FAILURE_MESSAGE),
        (r) {
      notificationsModel = r;
      notificationCounter = r.count!;
    });
    final failureOrNotifications = await _mainNotifications();
    failureOrNotifications
        .fold((l) => _toast.value = Event(SERVER_FAILURE_MESSAGE), (r) {
      _notEntity = r;
      notifyListeners();
    });
    _loading.value = false;
  }
}
