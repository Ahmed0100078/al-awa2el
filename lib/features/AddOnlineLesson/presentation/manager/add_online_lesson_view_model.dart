import 'package:flutter/material.dart';
import 'package:madaresco/Util/Event.dart';
import 'package:madaresco/features/AddOnlineLesson/domain/entities/add_online_lesson_entity.dart';
import 'package:madaresco/features/AddOnlineLesson/domain/entities/students_entity.dart';
import 'package:madaresco/features/AddOnlineLesson/domain/use_cases/add_online_lesson_use_case.dart';
import 'package:madaresco/features/AddOnlineLesson/domain/use_cases/get_stages_use_case.dart';
import 'package:madaresco/features/AddOnlineLesson/domain/use_cases/get_students_use_case.dart';
import 'package:madaresco/features/Login/presentation/manager/LoginViewModel.dart';
import 'package:madaresco/features/Register/domain/entities/item_entity.dart';
import 'package:madaresco/features/Register/domain/use_cases/get_grades_use_case.dart';
import 'package:madaresco/features/Register/domain/use_cases/get_sections_use_case.dart';
import 'package:madaresco/features/UploadLesson/domain/use_cases/get_subjects_use_case.dart';

class AddOnlineLessonViewModel extends ChangeNotifier {

  GetStudentsUseCase _studentsUseCase;
  GetStagesUseCase _stagesUseCase;
  AddOnlineLessonUseCase _onlineLessonUseCase;
  GetGradesUseCase _gradesUseCase;
  GetSectionsUseCase _sectionsUseCase;
  GetSubjectsUseCase _subjectsUseCase;

  AddOnlineLessonViewModel({
    required GetStudentsUseCase studentsUseCase,
    required GetStagesUseCase stagesUseCase,
    required AddOnlineLessonUseCase onlineLessonUseCase,
    required GetGradesUseCase gradesUseCase,
    required GetSectionsUseCase sectionsUseCase,
    required GetSubjectsUseCase subjectsUseCase,
  })  : _studentsUseCase = studentsUseCase,
        _stagesUseCase = stagesUseCase,
        _onlineLessonUseCase = onlineLessonUseCase,
        _gradesUseCase = gradesUseCase,
        _sectionsUseCase = sectionsUseCase,
        _subjectsUseCase = subjectsUseCase {
    getStages();
  }

  ValueNotifier<bool> _loading = ValueNotifier(false);
  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _paginationLoading = ValueNotifier(false);
  ValueNotifier<bool> get paginationLoading => _paginationLoading;
  ValueNotifier<Event<String>> _toast = ValueNotifier(Event(''));
  ValueNotifier<Event<String>> get toast => _toast;
  List<Students> _students = [];
  List<Students> get students => _students;
  AddOnlineLessonEntity? _onlineLessonEntity;
  ItemsEntity _stageEntity = ItemsEntity(items: []);
  StudentsEntity _studentsEntity = StudentsEntity(students: [], next: '');
  StudentsEntity get studentEntity => _studentsEntity;
  ItemsEntity get stageEntity => _stageEntity;
  ItemsEntity _grades = ItemsEntity(items: []);
  ItemsEntity get grades => _grades;
  ItemsEntity _subjects = ItemsEntity(items: []);
  ItemsEntity get subjects => _subjects;
  ItemsEntity _sections = ItemsEntity(items: []);
  ItemsEntity get sections => _sections;

  Item _selectedStage = Item(name: '', id: null);
  set selectedStage(Item selected) {
    _selectedStage = selected;
    getGrades();
    notifyListeners();
  }

  Item get selectedStage => _selectedStage;
  Item _selectedGrades = Item(name: '', id: null);
  set selectedGrades(Item grades) {
    _selectedGrades = grades;
    getSubjects();
    getSections();
    notifyListeners();
  }

  Item get selectedGrades => _selectedGrades;

  Item _selectedSubject = Item(name: '', id: null);

  set selectedSubject(Item subject) {
    _selectedSubject = subject;
    notifyListeners();
  }

  Item get selectedSubject => _selectedSubject;
  Item _selectedSection = Item(name: '', id: null);

  set selectedSection(Item section) {
    _selectedSection = section;
    notifyListeners();
  }

  Item get selectedSection => _selectedSection;
  String _lessonTitle = '';
  set lessonTitle(String title) => _lessonTitle = title;
  String _lessonLink = '';
  set lessonLink(String title) => _lessonLink = title;

  void getStages() async {
    _loading.value = true;
    final failureOrStages = await _stagesUseCase();
    failureOrStages.fold((l) => _toast.value = Event(SERVER_FAILURE_MESSAGE),
        (r) {
      _stageEntity = r;
      notifyListeners();
    });
    _loading.value = false;
  }

  void getStudents(int sectionId, [pagination = false]) async {
    // pagination ? _paginationLoading.value = true : _loading.value = true;
    final failureOrStudents = await _studentsUseCase(
      sectionId, /*studentsPage*/
    );
    failureOrStudents.fold((l) => _toast.value = Event(SERVER_FAILURE_MESSAGE),
        (r) {
      if (pagination) {
        _studentsEntity.students.addAll(r.students);
        // _studentsEntity.next = r.next;
      } else {
        _studentsEntity = r;
      }
      /* if (r.next != null) {
        studentsPage++;
      }*/
      notifyListeners();
    });
    /* pagination ? _paginationLoading.value = false : _loading.value = false;*/
  }

  Future<bool> addLesson() async {
    bool result = false;
    if (_selectedGrades.id == null ||
        _selectedStage.id == null ||
        _selectedSection.id == null ||
        _selectedSubject.id == null) {
      _toast.value = Event('all_fields_requiered');
    } else {
      if (_students.isEmpty) {
        _toast.value = Event('select_students_error');
      } else {
        _onlineLessonEntity = AddOnlineLessonEntity(
          sectionId: _selectedSection.id!,
          subjectId: _selectedSubject.id!,
          name: _lessonTitle,
          link: _lessonLink,
          students: _students.map((e) => e.id).toList(),
        );
        _loading.value = true;
        print('addLessonOrFailure aloo');
        print('_onlineLessonEntity! ${_onlineLessonEntity!}');
        final addLessonOrFailure =
            await _onlineLessonUseCase(_onlineLessonEntity!);
        addLessonOrFailure.fold((l) {
          print('addLessonOrFailure left $l');
          _toast.value = Event(SERVER_FAILURE_MESSAGE);
        }, (r) {
          print('addLessonOrFailure right $r');
          result = r;
        });
      }
    }
    _loading.value = false;
    return result;
  }

  void addStudent(Students students) {
    _students.add(students);
    notifyListeners();
  }

  void removeStudent(Students students) {
    _students.remove(students);
    notifyListeners();
  }

  void getGrades() async {
    _loading.value = true;
    final gradesOrFailure = await _gradesUseCase(_selectedStage.id!);
    gradesOrFailure.fold(
        (l) => _toast.value = Event(SERVER_FAILURE_MESSAGE),
        (r) {
      _grades = r;
      notifyListeners();
    },
    );
    _loading.value = false;
  }

  void getSections() async {
    _loading.value = true;
    final failureOrSections = await _sectionsUseCase(_selectedGrades.id!);
    failureOrSections.fold((l) => _toast.value = Event(SERVER_FAILURE_MESSAGE),
        (r) {
      _sections = r;
      notifyListeners();
    });
    _loading.value = false;
  }

  void getSubjects() async {
    _loading.value = true;
    final failureOrSubjects = await _subjectsUseCase(_selectedGrades.id!);
    failureOrSubjects.fold((l) => _toast.value = Event(SERVER_FAILURE_MESSAGE),
        (r) {
      _subjects = r;
      notifyListeners();
    });
    _loading.value = false;
  }
}
