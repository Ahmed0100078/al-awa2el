import 'package:flutter/material.dart';
import 'package:madaresco/Util/Event.dart';
import 'package:madaresco/features/Login/presentation/manager/LoginViewModel.dart';
import 'package:madaresco/features/SchoolNews/domain/entities/school_news_entity.dart';
import 'package:madaresco/features/SchoolNews/domain/use_cases/get_school_news_use_case.dart';

class SchoolNewsViewModel extends ChangeNotifier {
  ValueNotifier<bool> _loading = ValueNotifier(false);

  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _paginationLoading = ValueNotifier(false);

  ValueNotifier<bool> get paginationLoading => _paginationLoading;
  int _page = 1;

  int get page => _page;
  ValueNotifier<Event<String>> _toast = ValueNotifier(Event(''));

  ValueNotifier<Event<String>> get toast => _toast;

  SchoolNewsEntity _entity = SchoolNewsEntity(news: [], next: '');
  SchoolNewsEntity get entity => _entity;

  GetSchoolNewsUseCase _schoolNewsUseCase;

  SchoolNewsViewModel({
    required GetSchoolNewsUseCase schoolNewsUseCase,
  }) : _schoolNewsUseCase = schoolNewsUseCase {
    getSchoolNews();
  }

  void getSchoolNews([bool pagination = false]) async {
    pagination ? _paginationLoading.value = true : _loading.value = true;
    final failureOrLessons = await _schoolNewsUseCase(page);
    failureOrLessons.fold((l) => _toast.value = Event(SERVER_FAILURE_MESSAGE),
        (r) {
      if (pagination) {
        _entity.news.addAll(r.news);
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
