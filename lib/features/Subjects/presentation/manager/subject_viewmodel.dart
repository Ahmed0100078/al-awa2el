import 'package:flutter/material.dart';
import 'package:madaresco/Util/Event.dart';
import 'package:madaresco/features/Login/presentation/manager/LoginViewModel.dart';
import 'package:madaresco/features/Subjects/domain/entities/subject_entity.dart';
import 'package:madaresco/features/Subjects/domain/use_cases/get_subjects_use_case.dart';

class SubjectViewModel extends ChangeNotifier {
  ValueNotifier<bool> _loading = ValueNotifier(false);

  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<Event<String>> _toast = ValueNotifier(Event(''));

  ValueNotifier<Event<String>> get toast => _toast;
  SubjectEntity _subjectEntity = SubjectEntity(subjects: [], next: '');

  SubjectEntity get subjectEntity => _subjectEntity;
  GetSubjectsUseCase _subjectsUseCase;

  SubjectViewModel({
    required GetSubjectsUseCase subjectsUseCase,
  }) : _subjectsUseCase = subjectsUseCase {
    getData();
  }

  void getData() async {
    _loading.value = true;
    final failureOrSubjects = await _subjectsUseCase();
    failureOrSubjects.fold((l) => _toast.value = Event(SERVER_FAILURE_MESSAGE),
        (r) {
      _subjectEntity = r;
      notifyListeners();
    });
    _loading.value = false;
  }
}
