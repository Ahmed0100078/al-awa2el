import 'package:flutter/material.dart';
import 'package:madaresco/Util/Event.dart';
import 'package:madaresco/features/Login/presentation/manager/LoginViewModel.dart';
import 'package:madaresco/features/SchoolNewsDetails/domain/entities/school_news_details_entity.dart';
import 'package:madaresco/features/SchoolNewsDetails/domain/use_cases/get_school_news_details_use_case.dart';

class SchoolNewsDetailsViewModel extends ChangeNotifier {
  ValueNotifier<bool> _loading = ValueNotifier(false);

  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<Event<String>> _toast = ValueNotifier(Event(''));

  ValueNotifier<Event<String>> get toast => _toast;

  SchoolNewsDetailsEntity _entity = SchoolNewsDetailsEntity(
      image: '', date: '', title: '', description: '', number: 0);

  SchoolNewsDetailsEntity get entity => _entity;

  ValueNotifier<int> _id = ValueNotifier(-1);

  set id(int i) => _id.value = i;

  GetSchoolNewsEntityUseCase _schoolNewsEntityUseCase;

  SchoolNewsDetailsViewModel({
    required GetSchoolNewsEntityUseCase schoolNewsEntityUseCase,
  }) : _schoolNewsEntityUseCase = schoolNewsEntityUseCase {
    _id.addListener(() {
      if (_id.value != -1) {
        getSchoolNewsDetails();
      }
    });
  }

  void getSchoolNewsDetails() async {
    _loading.value = true;
    final failureOrSchoolNewsDetails =
        await _schoolNewsEntityUseCase(_id.value);
    failureOrSchoolNewsDetails
        .fold((l) => _toast.value = Event(SERVER_FAILURE_MESSAGE), (r) {
      _entity = r;
      notifyListeners();
    });
    _loading.value = false;
  }
}
