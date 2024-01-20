import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class ExamSubjectsEntity extends Equatable {
  final List<ExamSubjectsData> examSubjects;
  String next;

  ExamSubjectsEntity({
    required this.examSubjects,
    required this.next,
  });

  @override
  List<Object> get props => [examSubjects, next];
}

class ExamSubjectsData extends Equatable {
  final int id;
  final String name;

  const ExamSubjectsData({
    required this.id,
    required this.name,
  });

  @override
  List<Object> get props => [id, name];
}
