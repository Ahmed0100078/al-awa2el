import 'package:flutter/material.dart';
import 'package:madaresco/Util/Event.dart';
import 'package:madaresco/features/Curricula/domain/entities/filter_entity.dart';
import 'package:madaresco/features/Curricula/domain/use_cases/get_grades_use_case.dart';
import 'package:madaresco/features/Curricula/domain/use_cases/get_stages_use_case.dart';
import 'package:madaresco/features/Login/presentation/manager/LoginViewModel.dart';
import 'package:madaresco/features/MadarescoLessons/domain/entities/madaresco_lessons_entitiy.dart';
import 'package:madaresco/features/MadarescoLessons/domain/use_cases/get_madaresco_lessons_use_case.dart';

class MadarescoLessonsViewModel extends ChangeNotifier {
  ValueNotifier<bool> _loading = ValueNotifier(false);

  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _paginationLoading = ValueNotifier(false);

  ValueNotifier<bool> get paginationLoading => _paginationLoading;
  ValueNotifier<Event<String>> _toast = ValueNotifier(Event(''));

  ValueNotifier<Event<String>> get toast => _toast;

  MadarescoLessonsEntity _entity =
      MadarescoLessonsEntity(lessons: [], next: '');

  MadarescoLessonsEntity get entity => _entity;

  String _selectedTerm = '';
  List<String> _terms = ['first', 'second'];
  List<String> get terms => _terms;
  set selectedTerm(String s) {
    _selectedTerm = s;
    getMadarescooLessons();
  }

  Filters _selectedStage = Filters(id: null, name: null);
  Filters get selectedStage => _selectedStage;
  set selectedStage(Filters stage) {
    _selectedStage = stage;
    getGrades(stage.id!);
    getMadarescooLessons();
  }

  Filters _selectedGrade = Filters(id: null, name: null);
  Filters get selectedGrade => _selectedGrade;
  set selectedGrade(Filters grade) {
    _selectedGrade = grade;
    getMadarescooLessons();
  }

  FilterEntity _grades = FilterEntity(filters: []);
  FilterEntity _stages = FilterEntity(filters: []);
  FilterEntity get grades => _grades;
  FilterEntity get stages => _stages;

  String get selectedTerm => _selectedTerm;
  int _page = 1;

  int get page => _page;

  GetMadarescoLessonsUseCase _madarescoLessonsUseCase;

  GetCurriculaGradesUseCase _gradesUseCase;
  GetCurriculaStagesUseCase _stagesUseCase;

  MadarescoLessonsViewModel({
    required GetMadarescoLessonsUseCase madarescoLessonsUseCase,
    required GetCurriculaGradesUseCase gradesUseCase,
    required GetCurriculaStagesUseCase stagesUseCase,
  })  : _madarescoLessonsUseCase = madarescoLessonsUseCase,
        _gradesUseCase = gradesUseCase,
        _stagesUseCase = stagesUseCase {
    getStages();
    getMadarescooLessons();
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

  void getMadarescooLessons([bool pagination = false]) async {
    pagination ? _paginationLoading.value = true : _loading.value = true;
    final failureOrLessons = await _madarescoLessonsUseCase(
      _selectedStage.id,
      _selectedGrade.id,
      _selectedTerm,
      _page,
    );
    failureOrLessons.fold((l) => _toast.value = Event(SERVER_FAILURE_MESSAGE),
        (r) {
      if (pagination) {
        _entity.lessons.addAll(r.lessons);
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
}
