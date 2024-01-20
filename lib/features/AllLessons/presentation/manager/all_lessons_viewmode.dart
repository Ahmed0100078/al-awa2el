import 'package:flutter/material.dart';
import 'package:madaresco/Util/Event.dart';
import 'package:madaresco/features/AllLessons/domain/entities/all_lessons_entity.dart';
import 'package:madaresco/features/AllLessons/domain/use_cases/get_lessons_use_case.dart';
import 'package:madaresco/features/Login/presentation/manager/LoginViewModel.dart';

class AllLessonsViewModel extends ChangeNotifier {
  ValueNotifier<bool> _loading = ValueNotifier(false);

  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _paginationLoading = ValueNotifier(false);

  ValueNotifier<bool> get paginationLoading => _paginationLoading;
  ValueNotifier<Event<String>> _toast = ValueNotifier(Event(''));

  ValueNotifier<Event<String>> get toast => _toast;

  AllLessonsEntity _entity = AllLessonsEntity(lessons: [], next: '');

  AllLessonsEntity get entity => _entity;
  ValueNotifier<int> _id = ValueNotifier(-1);

  set id(int id) => _id.value = id;
  int _page = 1;

  int get page => _page;

  GetLessonsUseCase _getLessonsUseCase;

  AllLessonsViewModel({
    required GetLessonsUseCase getLessonsUseCase,
  }) : _getLessonsUseCase = getLessonsUseCase {
    _id.addListener(() {
      if (_id.value != -1) {
        getLessons();
      }
    });
  }

  void getLessons({bool pagination = false}) async {
    pagination ? _paginationLoading.value = true : _loading.value = true;
    final failureOrLessons = await _getLessonsUseCase(_id.value, page);
    failureOrLessons.fold((l) => _toast.value = Event(SERVER_FAILURE_MESSAGE),
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
