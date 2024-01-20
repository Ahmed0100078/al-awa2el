import 'package:flutter/material.dart';
import 'package:madaresco/Util/Event.dart';
import 'package:madaresco/features/AllTeacher/domain/entities/all_teachers_entity.dart';
import 'package:madaresco/features/AllTeacher/domain/use_cases/get_all_teachers_use_case.dart';
import 'package:madaresco/features/Login/presentation/manager/LoginViewModel.dart';

class AllTeachersViewModel extends ChangeNotifier {
  ValueNotifier<bool> _loading = ValueNotifier(false);

  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _paginationLoading = ValueNotifier(false);

  ValueNotifier<bool> get paginationLoading => _paginationLoading;
  ValueNotifier<Event<String>> _toast = ValueNotifier(Event(''));

  ValueNotifier<Event<String>> get toast => _toast;
  int _page = 1;

  int get page => _page;

  AllTeachersEntity _entity = AllTeachersEntity(teachers: [], next: '');

  AllTeachersEntity get entity => _entity;

  GetAllTeachersUseCase _allTeachersUseCase;

  AllTeachersViewModel({
    required GetAllTeachersUseCase allTeachersUseCase,
  }) : _allTeachersUseCase = allTeachersUseCase {
    getAllTeachers();
  }

  void getAllTeachers([bool pagination = false]) async {
    pagination ? _paginationLoading.value = true : _loading.value = true;
    final failureOrSubjects = await _allTeachersUseCase(_page);
    failureOrSubjects.fold((l) => _toast.value = Event(SERVER_FAILURE_MESSAGE),
        (r) {
      if (pagination) {
        _entity.teachers.addAll(r.teachers);
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
