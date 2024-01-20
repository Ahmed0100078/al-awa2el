import 'package:flutter/material.dart';
import 'package:madaresco/Util/Event.dart';
import 'package:madaresco/features/Absence/domain/entities/absence_entity.dart';
import 'package:madaresco/features/Absence/domain/use_cases/get_absence_use_case.dart';
import 'package:madaresco/features/Login/presentation/manager/LoginViewModel.dart';

class AbsenceViewModel extends ChangeNotifier {
  ValueNotifier<bool> _loading = ValueNotifier(false);

  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<Event<String>> _toast = ValueNotifier(Event(''));

  ValueNotifier<Event<String>> get toast => _toast;

  AbsenceEntity _entity = AbsenceEntity(absenceData: []);

  AbsenceEntity get entity => _entity;

  GetAbsenceUseCase _absenceUseCase;

  ValueNotifier<String> _selectedDate = ValueNotifier('');

  ValueNotifier<String> get gselectedDate => _selectedDate;

  set selectedDate(String date) {
    _selectedDate.value = date;
  }

  AbsenceViewModel({
    required GetAbsenceUseCase absenceUseCase,
  }) : _absenceUseCase = absenceUseCase {
    getAbsence();
    _selectedDate.addListener(() {
      if (_selectedDate.value.isNotEmpty) {
        getAbsence(_selectedDate.value);
      }
    });
  }

  void getAbsence([String date = '']) async {
    _loading.value = true;
    final failureOrAbsences = await _absenceUseCase(date);
    failureOrAbsences.fold((l) => _toast.value = Event(SERVER_FAILURE_MESSAGE),
        (r) {
      _entity = r;
      notifyListeners();
    });
    _loading.value = false;
  }
}
