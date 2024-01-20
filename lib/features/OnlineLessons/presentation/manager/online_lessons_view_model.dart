import 'package:flutter/material.dart';
import 'package:madaresco/Util/Event.dart';
import 'package:madaresco/features/Login/presentation/manager/LoginViewModel.dart';
import 'package:madaresco/features/OnlineLessons/domain/entities/online_lessons_entity.dart';
import 'package:madaresco/features/OnlineLessons/domain/use_cases/get_online_lessons_use_case.dart';

class OnlineLessonsViewModel extends ChangeNotifier {
  ValueNotifier<bool> _loading = ValueNotifier(false);

  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _paginationLoading = ValueNotifier(false);

  ValueNotifier<bool> get paginationLoading => _paginationLoading;
  ValueNotifier<Event<String>> _toast = ValueNotifier(Event(''));
  int _page = 1;

  ValueNotifier<Event<String>> get toast => _toast;
  OnlineLessonsEntity _entity = OnlineLessonsEntity(lessons: [], next: '');
  OnlineLessonsEntity get entity => _entity;

  GetOnlineLessonsUseCase _onlineLessonsUseCase;

  OnlineLessonsViewModel({
    required GetOnlineLessonsUseCase onlineLessonsUseCase,
  }) : _onlineLessonsUseCase = onlineLessonsUseCase {
    getOnlineLessons();
  }

  void getOnlineLessons([bool pagination = false]) async {
    pagination ? _paginationLoading.value = true : _loading.value = true;
    final failureOrSubjects = await _onlineLessonsUseCase(_page);
    failureOrSubjects.fold((l) => _toast.value = Event(SERVER_FAILURE_MESSAGE),
        (r) {
      if (pagination) {
        _entity.lessons.addAll(r.lessons);
        _entity.next = r.next;
      } else {
        _entity = r;
      }
      if (r.next.isNotEmpty) {
        _page++;
      }
      notifyListeners();
    });
    pagination ? _paginationLoading.value = false : _loading.value = false;
  }
}
