import 'package:equatable/equatable.dart';

class ExamScheduleEntity extends Equatable {
  final String name;
  final List<ExamSubjects> examSubjects;

  const ExamScheduleEntity({
    required this.name,
    required this.examSubjects,
  });

  @override
  List<Object> get props => [name, examSubjects];
}

class ExamSubjects extends Equatable {
  final name, date, time, duration;

  const ExamSubjects({
    required this.name,
    required this.date,
    required this.time,
    required this.duration,
  });

  @override
  List<Object> get props => [name, date, time, duration];
}
