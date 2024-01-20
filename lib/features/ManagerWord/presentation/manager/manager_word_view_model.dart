import 'package:flutter/material.dart';
import 'package:madaresco/Util/Event.dart';
import 'package:madaresco/features/Login/presentation/manager/LoginViewModel.dart';
import 'package:madaresco/features/ManagerWord/domain/entities/manager_word_entity.dart';
import 'package:madaresco/features/ManagerWord/domain/use_cases/manager_word_use_case.dart';

class ManagerWordViewModel extends ChangeNotifier {
  ValueNotifier<bool> _loading = ValueNotifier(false);

  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<Event<String>> _toast = ValueNotifier(Event(''));

  ValueNotifier<Event<String>> get toast => _toast;
  ManagerWordEntity _entity = ManagerWordEntity(image: '', name: '', word: '');

  ManagerWordEntity get entity => _entity;

  GetManagerWordUseCase _managerWordUseCase;

  ManagerWordViewModel({
    required GetManagerWordUseCase managerWordUseCase,
  }) : _managerWordUseCase = managerWordUseCase {
    getManagerWord();
  }

  void getManagerWord() async {
    _loading.value = true;
    final failureOrManagerWord = await _managerWordUseCase();
    failureOrManagerWord
        .fold((l) => _toast.value = Event(SERVER_FAILURE_MESSAGE), (r) {
      _entity = r;
      notifyListeners();
    });
    _loading.value = false;
  }
}
