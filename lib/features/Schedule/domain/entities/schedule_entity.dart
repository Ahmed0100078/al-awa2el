import 'package:equatable/equatable.dart';

class ScheduleEntity extends Equatable {
  final List<ScheduleSubject> schedules;

  const ScheduleEntity({
    required this.schedules,
  });

  @override
  List<Object> get props => [schedules];
}

class ScheduleSubject extends Equatable {
  final String subjectn, time, duration, teachern, classroom, division;

  const ScheduleSubject({
    required this.subjectn,
    required this.time,
    required this.duration,
    required this.teachern,
    required this.classroom,
    required this.division,
  });

  @override
  List<Object> get props => [subjectn, time, duration, teachern];
}
