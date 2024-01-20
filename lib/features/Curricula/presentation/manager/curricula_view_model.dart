import 'package:flutter/material.dart';
import 'package:madaresco/Util/Event.dart';
import 'package:madaresco/features/Curricula/domain/entities/curricula_entity.dart';
import 'package:madaresco/features/Curricula/domain/entities/filter_entity.dart';
import 'package:madaresco/features/Curricula/domain/use_cases/get_curricula_use_case.dart';
import 'package:madaresco/features/Curricula/domain/use_cases/get_grades_use_case.dart';
import 'package:madaresco/features/Curricula/domain/use_cases/get_stages_use_case.dart';
import 'package:madaresco/features/Curricula/domain/use_cases/get_subjects_use_case.dart';
import 'package:madaresco/features/Login/presentation/manager/LoginViewModel.dart';

class CurriculaViewModel extends ChangeNotifier {
  ValueNotifier<bool> _loading = ValueNotifier(false);

  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<Event<String>> _toast = ValueNotifier(Event(''));

  ValueNotifier<Event<String>> get toast => _toast;
  ValueNotifier<bool> _paginationLoading = ValueNotifier(false);
  String _selectedTerm = '';
  List<String> _terms = ['first', 'second'];
  List<String> get terms => _terms;
  set selectedTerm(String s) {
    _selectedTerm = s;
    getCurricula();
  }

  String get selectedTerm => _selectedTerm;
  int _page = 1;

  ValueNotifier<bool> get paginationLoading => _paginationLoading;
  Filters _selectedStage = Filters(id: null, name: null);
  Filters get selectedStage => _selectedStage;
  set selectedStage(Filters stage) {
    _selectedStage = stage;
    getGrades(stage.id!);
    getCurricula();
  }

  Filters _selectedGrade = Filters(id: null, name: null);
  Filters get selectedGrade => _selectedGrade;
  set selectedGrade(Filters grade) {
    _selectedGrade = grade;
    getSubjects(grade.id!);
    getCurricula();
  }

  Filters _selectedSubject = Filters(id: null, name: null);
  Filters get selectedSubject => _selectedSubject;
  set selectedSubject(Filters subject) {
    _selectedSubject = subject;
    getCurricula();
  }

  FilterEntity _grades = FilterEntity(filters: []);
  FilterEntity _stages = FilterEntity(filters: []);
  FilterEntity get grades => _grades;
  FilterEntity get stages => _stages;
  FilterEntity _subjects = FilterEntity(filters: []);
  FilterEntity get subjects => _subjects;

  CurriculaEntity _entity = CurriculaEntity(curricals: [], next: '');
  CurriculaEntity get entity => _entity;

  GetCurriculaGradesUseCase _gradesUseCase;
  GetCurriculaStagesUseCase _stagesUseCase;
  GetCurriculaUseCase _curriculaUseCase;
  GetCurriculaSubjectsUseCase _subjectsUseCase;

  CurriculaViewModel(
      {required GetCurriculaGradesUseCase gradesUseCase,
      required GetCurriculaStagesUseCase stagesUseCase,
      required GetCurriculaUseCase curriculaUseCase,
      required GetCurriculaSubjectsUseCase subjectsUseCase})
      : _gradesUseCase = gradesUseCase,
        _stagesUseCase = stagesUseCase,
        _subjectsUseCase = subjectsUseCase,
        _curriculaUseCase = curriculaUseCase {
    getStages();
    getCurricula();
  }

  void getStages() async {
    _loading.value = true;
    final failureOrStages = await _stagesUseCase();
    failureOrStages.fold((l) => _toast.value = Event(SERVER_FAILURE_MESSAGE),
        (r) {
      _stages = r;
      notifyListeners();
    });
    _loading.value = false;
  }

  void getCurricula({bool pagination = false}) async {
    pagination ? _paginationLoading.value = true : _loading.value = true;
    final failureOrLessons = await _curriculaUseCase(
      stageId: _selectedStage.id,
      gradeId: _selectedGrade.id,
      subjectId: _selectedSubject.id,
      term: _selectedTerm,
      page: _page,
    );
    failureOrLessons.fold((l) => _toast.value = Event(SERVER_FAILURE_MESSAGE),
        (r) {
      if (pagination) {
        _entity.curricals.addAll(r.curricals);
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

  void getGrades(int id) async {
    _loading.value = true;
    final failureOrStages = await _gradesUseCase(id);
    failureOrStages.fold((l) => _toast.value = Event(SERVER_FAILURE_MESSAGE),
        (r) {
      _grades = r;
      notifyListeners();
    });
    _loading.value = false;
  }

  void getSubjects(int id) async {
    _loading.value = true;
    final failureOrSubjects = await _subjectsUseCase(id);
    failureOrSubjects.fold((l) => _toast.value = Event(SERVER_FAILURE_MESSAGE),
        (r) {
      _subjects = r;
      notifyListeners();
    });
    _loading.value = false;
  }
}
