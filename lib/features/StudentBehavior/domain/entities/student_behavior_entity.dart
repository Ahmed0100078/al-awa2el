import 'package:equatable/equatable.dart';

class StudentBehaviorEntity extends Equatable {
  final String status, name, grade, avatar;
  final List<Warning> warningsList;

  StudentBehaviorEntity(
      {required this.status,
      required this.name,
      required this.grade,
      required this.avatar,
      required this.warningsList});

  @override
  List<Object> get props => [status, name, grade, avatar];
}

class Warning extends Equatable {
  final String title, date;

  Warning({required this.title, required this.date});

  @override
  List<Object> get props => [title, date];
}
