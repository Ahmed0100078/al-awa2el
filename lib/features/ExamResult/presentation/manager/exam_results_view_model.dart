import 'package:flutter/material.dart';
import 'package:madaresco/Util/Event.dart';
import 'package:madaresco/features/ExamResult/domain/entities/exam_result_entity.dart';
import 'package:madaresco/features/ExamResult/domain/use_cases/get_exams_results_use_case.dart';
import 'package:madaresco/features/Login/presentation/manager/LoginViewModel.dart';

import '../../domain/use_cases/get_exams_results_pdf_use_case.dart';

class ExamResultsViewModel extends ChangeNotifier {
  ValueNotifier<bool> _loading = ValueNotifier(false);
  ValueNotifier<bool> _loadingPdf = ValueNotifier(false);

  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> get loadingPdf => _loadingPdf;
  ValueNotifier<Event<String>> _toast = ValueNotifier(Event(''));
  ValueNotifier<Event<String>> _toastPdf = ValueNotifier(Event(''));

  ValueNotifier<Event<String>> get toast => _toast;
  ValueNotifier<Event<String>> get toastPdf => _toastPdf;

  ExamResultEntity _entity = ExamResultEntity(results: []);

  String examResultPdf = "";

  ExamResultEntity get entity => _entity;

  GetExamsResultsUseCase _examsResultsUseCase;
  GetExamsResultsPdfUseCase _getExamsResultsPdfUseCase;

  ExamResultsViewModel({
    required GetExamsResultsUseCase examsResultsUseCase,
    required GetExamsResultsPdfUseCase getExamsResultsPdfUseCase,
  })  : _examsResultsUseCase = examsResultsUseCase,
        _getExamsResultsPdfUseCase = getExamsResultsPdfUseCase {
    getExamsResult();
    getExamsResultPdf();
  }

  void getExamsResult() async {
    _loading.value = true;
    final failureOrExamResults = await _examsResultsUseCase();
    failureOrExamResults
        .fold((l) => _toast.value = Event(SERVER_FAILURE_MESSAGE), (r) {
      _entity = r;
      notifyListeners();
    });
    _loading.value = false;
  }

  void getExamsResultPdf() async {
    _loadingPdf.value = true;
    final failureOrExamResultsPdf = await _getExamsResultsPdfUseCase();
    failureOrExamResultsPdf
        .fold((l) => _toastPdf.value = Event(SERVER_FAILURE_MESSAGE), (r) {
      examResultPdf = r;
      notifyListeners();
    });
    _loadingPdf.value = false;
  }
}
