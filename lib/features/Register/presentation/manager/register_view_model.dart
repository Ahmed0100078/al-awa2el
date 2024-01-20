import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logging/logging.dart';
import 'package:madaresco/Util/Event.dart';
import 'package:madaresco/features/Login/presentation/manager/LoginViewModel.dart';
import 'package:madaresco/features/Register/domain/entities/item_entity.dart';
import 'package:madaresco/features/Register/domain/entities/send_entity.dart';
import 'package:madaresco/features/Register/domain/use_cases/get_grades_use_case.dart';
import 'package:madaresco/features/Register/domain/use_cases/get_schools_use_case.dart';
import 'package:madaresco/features/Register/domain/use_cases/get_sections_use_case.dart';
import 'package:madaresco/features/Register/domain/use_cases/get_stages_use_case.dart';
import 'package:madaresco/features/Register/domain/use_cases/register_school_use_case.dart';
import 'package:madaresco/features/Register/domain/use_cases/register_student_use_case.dart';
import 'package:madaresco/features/Register/domain/use_cases/register_teacher_use_case.dart';
import 'package:madaresco/features/Register/presentation/pages/succesful_registration.dart';
import 'package:madaresco/main.dart';

class RegisterViewModel extends ChangeNotifier {
  final Logger _logger = Logger('RegisterViewModel');
  ValueNotifier<bool> _loading = ValueNotifier(false);
  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<Event<String>> _toast = ValueNotifier(Event(''));
  ValueNotifier<Event<String>> get toast => _toast;
  ValueNotifier<Event<String>> _navigateTo = ValueNotifier(Event(''));
  ValueNotifier<Event<String>> get navigateTo => _navigateTo;
  ValueNotifier<RegisterType> _registerType =
      ValueNotifier(RegisterType.SCHOOL);
  RegisterType get registerType => _registerType.value;
  XFile? _image;
  XFile? get image => _image;

  set registerType(RegisterType type) {
    _registerType.value = type;
    _name = '';
    _password = '';
    _email = '';
    _phone = '';
    _image = null;
    if (type != RegisterType.SCHOOL) {
      getSchools();
    }
    notifyListeners();
  }

  SendEntity? _sendEntity;
  ItemsEntity _stages = ItemsEntity(items: []);
  ItemsEntity _schools = ItemsEntity(items: []);
  ItemsEntity _sections = ItemsEntity(items: []);
  ItemsEntity _grades = ItemsEntity(items: []);
  ItemsEntity get schools => _schools;
  ItemsEntity get stages => _stages;
  ItemsEntity get grades => _grades;
  ItemsEntity get sections => _sections;
  Item _selectedSchool = Item(id: null, name: null);
  Item get selectedSchool => _selectedSchool;
  String? _name,
      _phone,
      _email,
      _password,
      _address,
      _city,
      _country,
      _managerName;

  set name(String n) => _name = n;

  set email(String e) => _email = e;

  set phone(String p) => _phone = p;

  set password(String pass) => _password = pass;

  set address(String add) => _address = add;
  set city(String c) => _city = c;
  set country(String co) => _country = co;
  set managerName(String name) => _managerName = name;
  set selectedSchool(Item entity) {
    _selectedSchool = entity;
    getStages();
    notifyListeners();
  }

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
    getSections();
    notifyListeners();
  }

  Item get selectedGrades => _selectedGrades;
  Item _selectedSection = Item(name: '', id: null);

  set selectedSection(Item section) {
    _selectedSection = section;
    notifyListeners();
  }

  Item get selectedSection => _selectedSection;

  RegisterSchoolUseCase? _registerSchoolUseCase;
  RegisterStudentUseCase? _registerStudentUseCase;
  RegisterTeacherUseCase? _registerTeacherUseCase;
  GetSchoolsUseCase? _schoolsWithGrades;
  GetSectionsUseCase? _sectionsUseCase;
  GetStagesUseCase? _stagesUseCase;
  GetGradesUseCase? _gradesUseCase;

  RegisterViewModel({
    required RegisterSchoolUseCase registerSchoolUseCase,
    required RegisterStudentUseCase registerStudentUseCase,
    required RegisterTeacherUseCase registerTeacherUseCase,
    required GetSchoolsUseCase schoolsWithGrades,
    required GetStagesUseCase stagesUseCase,
    required GetGradesUseCase gradesUseCase,
    required GetSectionsUseCase sectionsUseCase,
  })  : _registerSchoolUseCase = registerSchoolUseCase,
        _registerStudentUseCase = registerStudentUseCase,
        _registerTeacherUseCase = registerTeacherUseCase,
        _schoolsWithGrades = schoolsWithGrades,
        _stagesUseCase = stagesUseCase,
        _sectionsUseCase = sectionsUseCase,
        _gradesUseCase = gradesUseCase {
    //getSchools();
  }

  void getSchools() async {
    _loading.value = true;
    final failureOrSchools = await _schoolsWithGrades!();
    failureOrSchools.fold((l) => _toast.value = Event(SERVER_FAILURE_MESSAGE),
        (r) {
      _schools = r;
      notifyListeners();
    });
    _loading.value = false;
  }

  void registerStudent() async {
    if (_selectedSection.id != null && _selectedSchool.id != null) {
      if (_image != null) {
        _sendEntity = SendEntity(
          name: _name!,
          password: _password!,
          confirmPassword: _password!,
          mobile: _phone!,
          email: _email!,
          image: File(_image!.path),
          schoolId: _selectedSchool.id!,
          sectionId: _selectedSection.id!,
        );
        _loading.value = true;
        final failureOrRegistered =
            await _registerStudentUseCase!(_sendEntity!);
        failureOrRegistered
            .fold((l) => _toast.value = Event(SERVER_FAILURE_MESSAGE), (r) {
          _logger.fine(r.name);
          _selectedSection = Item(name: '', id: null);
          _selectedSchool = Item(name: '', id: null);
          _name = '';
          _password = '';
          _email = '';
          _phone = '';
          mainNavigatorKey.currentState!.pushReplacement(
            MaterialPageRoute(
              builder: (context) =>
                  SuccesfulRegistration(message: 'student_message'),
            ),
          );
        });
        _loading.value = false;
      } else {
        _toast.value = Event('select_image');
      }
    } else {
      _toast.value = Event('all_fields_requiered');
    }
  }

  void registerTeacher() async {
    if (_selectedSchool.id != null) {
      if (_image != null) {
        _sendEntity = SendEntity(
          name: _name!,
          password: _password!,
          confirmPassword: _password!,
          mobile: _phone!,
          email: _email!,
          image: File(_image!.path),
          schoolId: _selectedSchool.id!,
        );
        _loading.value = true;
        final failureOrRegistered =
            await _registerTeacherUseCase!(_sendEntity!);
        log('failureOrRegistered. $failureOrRegistered');
        failureOrRegistered.fold((l) {
          log("llllllllllllllllllllllllll  ${l.errMSg}");
          _toast.value = Event(l.errMSg!);
        }
            , (r) {
          _logger.fine(r.name);
          _selectedSchool = Item(name: null, id: null);
          _name = '';
          _password = '';
          _email = '';
          _phone = '';
          mainNavigatorKey.currentState!.pushReplacement(
            MaterialPageRoute(
              builder: (context) =>
                  SuccesfulRegistration(message: 'student_message'),
            ),
          );
        });
        _loading.value = false;
      } else {
        _toast.value = Event('select_image');
      }
    } else {
      _toast.value = Event('all_fields_requiered');
    }
  }

  void registerSchool() async {
    print(_name);
    _sendEntity = SendEntity(
        name: _name!,
        password: _password!,
        confirmPassword: _password!,
        mobile: _phone!,
        address: _address!,
        email: _email!,
        managerName: _managerName!,
        city: _city!,
        country: _country!);
    _loading.value = true;
    final failureOrRegistered = await _registerSchoolUseCase!(_sendEntity!);
    failureOrRegistered.fold((l) {
      _toast.value = Event(SERVER_FAILURE_MESSAGE);
    }, (r) {
      _logger.fine(r.name);
      _name = '';
      _password = '';
      _email = '';
      _phone = '';
      mainNavigatorKey.currentState!.pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
              SuccesfulRegistration(message: 'school_message'),
        ),
      );
    });
    _loading.value = false;
  }

  Future getImage(ImageSource source) async {
    var image = await ImagePicker().pickImage(source: source);
    _image = image as XFile;
    notifyListeners();
  }

  void getStages() async {
    _loading.value = true;
    final failureOrStages = await _stagesUseCase!(_selectedSchool.id!);
    print(failureOrStages);
    failureOrStages.fold((l) => _toast.value = Event(SERVER_FAILURE_MESSAGE),
        (r) {
      _stages = r;
      notifyListeners();
    });
    _loading.value = false;
  }

  void getGrades() async {
    _loading.value = true;
    final failureOrGrades = await _gradesUseCase!(_selectedStage.id!);
    failureOrGrades.fold((l) => _toast.value = Event(SERVER_FAILURE_MESSAGE),
        (r) {
      _grades = r;
      notifyListeners();
    });
    _loading.value = false;
  }

  void getSections() async {
    _loading.value = true;
    final failureOrSections = await _sectionsUseCase!(_selectedGrades.id!);
    failureOrSections.fold((l) => _toast.value = Event(SERVER_FAILURE_MESSAGE),
        (r) {
      _sections = r;
      notifyListeners();
    });
    _loading.value = false;
  }
}

enum RegisterType { TEACHER, STUDENT, SCHOOL }
