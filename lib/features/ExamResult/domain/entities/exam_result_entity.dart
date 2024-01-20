import 'package:equatable/equatable.dart';

class ExamResultEntity extends Equatable {
  final List<ExamEntity> results;

  const ExamResultEntity({
    required this.results,
  });

  @override
  List<Object> get props => [results];
}

class ExamEntity extends Equatable {
  final String examName;
  final List<SubjectsEntity> subjects;
  final int total;

  const ExamEntity({
    required this.examName,
    required this.subjects,
    required this.total,
  });

  @override
  List<Object> get props => [subjects, examName, total];
}

class SubjectsEntity extends Equatable {
  final String subjectName;
  final int subjectTotal;
  final bool succeed;

  const SubjectsEntity({
    required this.succeed,
    required this.subjectName,
    required this.subjectTotal,
  });

  @override
  List<Object> get props => [subjectName, subjectTotal, succeed];
}
