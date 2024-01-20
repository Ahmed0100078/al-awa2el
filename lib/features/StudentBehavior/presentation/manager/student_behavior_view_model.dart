import 'package:flutter/cupertino.dart';
import 'package:madaresco/Util/Event.dart';
import 'package:madaresco/features/Login/presentation/manager/LoginViewModel.dart';
import 'package:madaresco/features/StudentBehavior/domain/entities/student_behavior_entity.dart';
import 'package:madaresco/features/StudentBehavior/domain/usecases/get_student_behavior_use_case.dart';

class StudentBehaviorViewModel extends ChangeNotifier {
  ValueNotifier<bool> _loading = ValueNotifier(false);

  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<Event<String>> _toast = ValueNotifier(Event(''));

  ValueNotifier<Event<String>> get toast => _toast;

  StudentBehaviorEntity _entity = StudentBehaviorEntity(
      status: '', name: '', grade: '', avatar: '', warningsList: []);

  StudentBehaviorEntity get entity => _entity;

  GetStudentBehaviorUseCase _studentBehaviorUseCase;
  StudentBehaviorViewModel(
      {required GetStudentBehaviorUseCase studentBehaviorUseCase})
      : _studentBehaviorUseCase = studentBehaviorUseCase {
    getData();
  }

  void getData() async {
    _loading.value = true;
    final failureOrStudentBehavior = await _studentBehaviorUseCase();
    failureOrStudentBehavior
        .fold((l) => _toast.value = Event(CACHE_FAILURE_MESSAGE), (r) {
      _entity = r;
      notifyListeners();
    });
    _loading.value = false;
  }
}
