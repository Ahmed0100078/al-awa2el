import 'package:equatable/equatable.dart';

class StudentsEntity extends Equatable {
  final List<Students> students;
  final String next;

  StudentsEntity({
    required this.students,
    required this.next,
  });

  @override
  List<Object> get props => [students, next];
}

// ignore: must_be_immutable
class Students extends Equatable {
  final int id;
  final String name;
  bool isSelected;

  Students({
    required this.id,
    required this.name,
    this.isSelected = false,
  });

  @override
  List<Object> get props => [id, name];
}
