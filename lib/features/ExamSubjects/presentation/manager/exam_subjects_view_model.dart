import 'package:flutter/material.dart';
import 'package:madaresco/Util/Event.dart';
import 'package:madaresco/features/ExamSubjects/domain/entities/exam_subjects_entity.dart';
import 'package:madaresco/features/ExamSubjects/domain/use_cases/get_subjects_use_case.dart';
import 'package:madaresco/features/Login/presentation/manager/LoginViewModel.dart';

class ExamSubjectsViewModel extends ChangeNotifier {
  ValueNotifier<bool> _loading = ValueNotifier(false);

  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _paginationLoading = ValueNotifier(false);

  ValueNotifier<bool> get paginationLoading => _paginationLoading;
  ValueNotifier<Event<String>> _toast = ValueNotifier(Event(''));

  ValueNotifier<Event<String>> get toast => _toast;
  int _page = 1;
  int get page => _page;

  ExamSubjectsEntity _entity = ExamSubjectsEntity(examSubjects: [], next: '');
  ExamSubjectsEntity get entity => _entity;
  GetExamSubjectsUseCase _examSubjectsUseCase;

  ExamSubjectsViewModel({
    required GetExamSubjectsUseCase examSubjectsUseCase,
  }) : _examSubjectsUseCase = examSubjectsUseCase {
    getData();
  }

  void getData({bool pagination = false}) async {
    pagination ? _paginationLoading.value = true : _loading.value = true;
    final failureOrSubjects = await _examSubjectsUseCase(page: _page);
    failureOrSubjects.fold((l) => _toast.value = Event(SERVER_FAILURE_MESSAGE),
        (r) {
      if (pagination) {
        _entity.examSubjects.addAll(r.examSubjects);
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
