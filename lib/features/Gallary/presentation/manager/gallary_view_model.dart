import 'package:flutter/material.dart';
import 'package:madaresco/Util/Event.dart';
import 'package:madaresco/features/Gallary/domain/entities/gallary_entity.dart';
import 'package:madaresco/features/Gallary/domain/use_cases/get_gallarys_use_case.dart';
import 'package:madaresco/features/Login/presentation/manager/LoginViewModel.dart';

class GallaryViewModel extends ChangeNotifier {
  ValueNotifier<bool> _loading = ValueNotifier(false);

  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<Event<String>> _toast = ValueNotifier(Event(''));
  ValueNotifier<bool> _paginationLoading = ValueNotifier(false);

  ValueNotifier<bool> get paginationLoading => _paginationLoading;
  int _page = 1;

  int get page => _page;

  ValueNotifier<Event<String>> get toast => _toast;

  GallaryEntity _entity = GallaryEntity(gallarys: [], next: '');

  GallaryEntity get entity => _entity;

  GetGallarysUseCase _gallarysUseCase;

  GallaryViewModel({
    required GetGallarysUseCase gallarysUseCase,
  }) : _gallarysUseCase = gallarysUseCase {
    getGallarys();
  }

  void getGallarys([bool pagination = false]) async {
    pagination ? _paginationLoading.value = true : _loading.value = true;
    final failureOrGallarys = await _gallarysUseCase(page);
    failureOrGallarys.fold((l) => _toast.value = Event(SERVER_FAILURE_MESSAGE),
        (r) {
      if (pagination) {
        _entity.gallarys.addAll(r.gallarys);
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
