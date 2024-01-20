import 'package:flutter/material.dart';
import 'package:madaresco/Util/Event.dart';
import 'package:madaresco/features/Annual/domain/entities/annual_entity.dart';
import 'package:madaresco/features/Annual/domain/use_cases/get_annuals_use_case.dart';
import 'package:madaresco/features/Login/presentation/manager/LoginViewModel.dart';

class AnnualsViewModel extends ChangeNotifier {
  ValueNotifier<bool> _loading = ValueNotifier(false);

  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<Event<String>> _toast = ValueNotifier(Event(''));

  ValueNotifier<Event<String>> get toast => _toast;

  AnnualEntity _entity =
      AnnualEntity(paids: [], partialyPaid: [], notPaid: []);

  AnnualEntity get entity => _entity;

  GetAnnualsUseCase _getAnnualsUseCase;

  AnnualsViewModel({
    required GetAnnualsUseCase getAnnualsUseCase,
  }) : _getAnnualsUseCase = getAnnualsUseCase {
    getData();
  }

  void getData() async {
    _loading.value = true;
    final failureOrAnnuals = await _getAnnualsUseCase();
    failureOrAnnuals.fold((l) => _toast.value = Event(SERVER_FAILURE_MESSAGE),
        (r) {
      _entity = r;
      notifyListeners();
    });
    _loading.value = false;
  }
}
