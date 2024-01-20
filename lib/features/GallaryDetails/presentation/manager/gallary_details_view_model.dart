import 'package:flutter/material.dart';
import 'package:madaresco/Util/Event.dart';
import 'package:madaresco/features/GallaryDetails/domain/entities/gallary_details_entities.dart';
import 'package:madaresco/features/GallaryDetails/domain/use_cases/get_gallary_details_use_case.dart';
import 'package:madaresco/features/Login/presentation/manager/LoginViewModel.dart';

class GallaryDetailsViewModel extends ChangeNotifier {
  ValueNotifier<bool> _loading = ValueNotifier(false);

  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<Event<String>> _toast = ValueNotifier(Event(''));

  ValueNotifier<Event<String>> get toast => _toast;

  GallaryDetailsEntity _detailsEntity =
      GallaryDetailsEntity(name: '', images: []);
  GallaryDetailsEntity get detailsEntity => _detailsEntity;

  ValueNotifier<int> _id = ValueNotifier(-1);

  set id(int id) {
    _id.value = id;
  }

  GetGallaryDetailsUseCase _gallaryDetailsUseCase;

  GallaryDetailsViewModel({
    required GetGallaryDetailsUseCase gallaryDetailsUseCase,
  }) : _gallaryDetailsUseCase = gallaryDetailsUseCase {
    _id.addListener(() {
      if (_id.value != -1) {
        print(_detailsEntity.images);
        getGallaryDetails();
      }
    });
  }

  void getGallaryDetails() async {
    _loading.value = true;
    final failureOrGallaryDetails = await _gallaryDetailsUseCase(_id.value);
    failureOrGallaryDetails
        .fold((l) => _toast.value = Event(SERVER_FAILURE_MESSAGE), (r) {
      _detailsEntity = r;
      notifyListeners();
    });

    _loading.value = false;
  }
}
