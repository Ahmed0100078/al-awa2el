import 'package:flutter/material.dart';
import 'package:madaresco/Util/Event.dart';
import 'package:madaresco/features/CurriculaDetails/domain/entities/curricula_details_entity.dart';
import 'package:madaresco/features/CurriculaDetails/domain/use_cases/get_curricula_details.dart';
import 'package:madaresco/features/Login/presentation/manager/LoginViewModel.dart';

class CurriculaDetailsViewModel extends ChangeNotifier {
  ValueNotifier<bool> _loading = ValueNotifier(false);

  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<Event<String>> _toast = ValueNotifier(Event(''));

  ValueNotifier<Event<String>> get toast => _toast;
  CurriculaDetailsEntity _entity =
      CurriculaDetailsEntity(name: '', image: '', pdfLink: '');
  CurriculaDetailsEntity get entity => _entity;

  GetCurriculaDetailsUseCase _curriculaDetailsUseCase;

  ValueNotifier<int> _id = ValueNotifier(-1);
  set id(int i) => _id.value = i;

  CurriculaDetailsViewModel({
    required GetCurriculaDetailsUseCase curriculaDetailsUseCase,
  }) : _curriculaDetailsUseCase = curriculaDetailsUseCase {
    _id.addListener(() {
      if (_id.value != -1) {
        getDetails();
      }
    });
  }

  void getDetails() async {
    _loading.value = true;
    final failureOrCurricula = await _curriculaDetailsUseCase(_id.value);
    failureOrCurricula.fold((l) => _toast.value = Event(SERVER_FAILURE_MESSAGE),
        (r) {
      _entity = r;
      notifyListeners();
    });
    _loading.value = false;
  }
}
