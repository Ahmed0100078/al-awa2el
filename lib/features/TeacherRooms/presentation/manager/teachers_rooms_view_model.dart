import 'package:flutter/material.dart';
import 'package:madaresco/Util/Event.dart';
import 'package:madaresco/features/Login/presentation/manager/LoginViewModel.dart';
import 'package:madaresco/features/TeacherRooms/domain/entities/teacher_rooms_entity.dart';
import 'package:madaresco/features/TeacherRooms/domain/use_cases/get_teacher_rooms_use_case.dart';

class TeacherRoomViewModel extends ChangeNotifier {
  ValueNotifier<bool> _loading = ValueNotifier(false);

  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _paginationLoading = ValueNotifier(false);

  ValueNotifier<bool> get paginationLoading => _paginationLoading;
  ValueNotifier<Event<String>> _toast = ValueNotifier(Event(''));

  ValueNotifier<Event<String>> get toast => _toast;
  int _page = 1;

  int get page => _page;

  TeacherRoomsEntity _entity = TeacherRoomsEntity(students: [], next: '');

  TeacherRoomsEntity get entity => _entity;

  GetTeacherRoomsUseCase _teacherRoomsUseCase;

  TeacherRoomViewModel({
    required GetTeacherRoomsUseCase teacherRoomsUseCase,
  }) : _teacherRoomsUseCase = teacherRoomsUseCase {
    getTeacherRooms();
  }

  void getTeacherRooms([bool pagination = false]) async {
    pagination ? _paginationLoading.value = true : _loading.value = true;
    final failureOrRooms = await _teacherRoomsUseCase(_page);
    failureOrRooms.fold((l) => _toast.value = Event(SERVER_FAILURE_MESSAGE),
        (r) {
      if (pagination) {
        _entity.students.addAll(r.students);
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
