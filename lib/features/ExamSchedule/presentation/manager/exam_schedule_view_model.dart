import 'package:flutter/material.dart';
import 'package:madaresco/Util/Event.dart';
import 'package:madaresco/features/ExamSchedule/domain/entities/exam_schedule_entity.dart';
import 'package:madaresco/features/ExamSchedule/domain/use_cases/get_exam_schedule_use_case.dart';
import 'package:madaresco/features/Login/presentation/manager/LoginViewModel.dart';

class ExamScheduleViewModel extends ChangeNotifier {
  ValueNotifier<bool> _loading = ValueNotifier(false);

  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<Event<String>> _toast = ValueNotifier(Event(''));

  ValueNotifier<Event<String>> get toast => _toast;
  ValueNotifier<int> _examId = ValueNotifier(-1);

  set examId(int id) => _examId.value = id;
  ExamScheduleEntity _entity =
      ExamScheduleEntity(name: '', examSubjects: []);

  ExamScheduleEntity get entity => _entity;
  GetExamScheduleUseCase _examScheduleUseCase;

  ExamScheduleViewModel({
    required GetExamScheduleUseCase examScheduleUseCase,
  }) : _examScheduleUseCase = examScheduleUseCase {
    _examId.addListener(() {
      if (_examId.value != -1) {
        getData();
      }
    });
  }

  void getData() async {
    _loading.value = true;
    final failureOrExam = await _examScheduleUseCase(_examId.value);
    failureOrExam.fold((l) => _toast.value = Event(SERVER_FAILURE_MESSAGE),
        (r) {
      _entity = r;
      notifyListeners();
    });
    _loading.value = false;
  }
}
