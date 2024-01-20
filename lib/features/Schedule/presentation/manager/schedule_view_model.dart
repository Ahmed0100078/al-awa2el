import 'package:flutter/material.dart';
import 'package:madaresco/Util/Event.dart';
import 'package:madaresco/features/Login/presentation/manager/LoginViewModel.dart';
import 'package:madaresco/features/Schedule/domain/entities/day_entity.dart';
import 'package:madaresco/features/Schedule/domain/entities/schedule_entity.dart';
import 'package:madaresco/features/Schedule/domain/use_cases/get_schedule_use_case.dart';

class ScheduleViewModel extends ChangeNotifier {
  ValueNotifier<bool> _loading = ValueNotifier(false);

  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<Event<String>> _toast = ValueNotifier(Event(''));

  ValueNotifier<Event<String>> get toast => _toast;

  ScheduleEntity _day1 = ScheduleEntity(schedules: []);

  ScheduleEntity get day1 => _day1;
  ScheduleEntity _day2 = ScheduleEntity(schedules: []);

  ScheduleEntity get day2 => _day2;
  ScheduleEntity _day3 = ScheduleEntity(schedules: []);

  ScheduleEntity get day3 => _day3;
  ScheduleEntity _day4 = ScheduleEntity(schedules: []);

  ScheduleEntity get day4 => _day4;
  ScheduleEntity _day5 = ScheduleEntity(schedules: []);

  ScheduleEntity get day5 => _day5;
  ScheduleEntity _day6 = ScheduleEntity(schedules: []);

  ScheduleEntity get day6 => _day6;
  ScheduleEntity _day7 = ScheduleEntity(schedules: []);

  ScheduleEntity get day7 => _day7;

  GetScheduleUseCase _scheduleUseCase;
  List<DayEntity> _days = [
    DayEntity(arname: 'السبت', enname: 'Saturday', no: 6, isOpen: false),
    DayEntity(arname: 'الاحد', enname: 'Sunday', no: 7, isOpen: false),
    DayEntity(arname: 'الأثنين', enname: 'Monday', no: 1, isOpen: false),
    DayEntity(arname: 'الثلاثاء', enname: 'Tuesday', no: 2, isOpen: false),
    DayEntity(arname: 'الاربعاء', enname: 'Wednesday', no: 3, isOpen: false),
    DayEntity(arname: 'الخميس', enname: 'Thursday', no: 4, isOpen: false),
    DayEntity(arname: 'الجمعة', enname: 'Friday', no: 5, isOpen: false),
  ];

  List<DayEntity> get days => _days;

  ScheduleViewModel({
    required GetScheduleUseCase scheduleUseCase,
  }) : _scheduleUseCase = scheduleUseCase {
    getData(1);
    getData(2);
    getData(3);
    getData(4);
    getData(5);
    getData(6);
    getData(7);
  }

  Future<void> getData(int day) async {
    _loading.value = true;
    final failureOrSchedule = await _scheduleUseCase(day);
    failureOrSchedule.fold((l) => _toast.value = Event(SERVER_FAILURE_MESSAGE),
        (r) {
      switch (day) {
        case 1:
          _day1 = r;
          print(r.schedules[0].duration);
          break;
        case 2:
          _day2 = r;
          break;
        case 3:
          _day3 = r;
          break;
        case 4:
          _day4 = r;
          break;
        case 5:
          _day5 = r;
          break;
        case 6:
          _day6 = r;
          break;
        case 7:
          _day7 = r;
          break;
      }
      notifyListeners();
    });
    _loading.value = false;
  }
}
