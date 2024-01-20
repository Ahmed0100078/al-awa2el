import 'package:equatable/equatable.dart';

class MainTeacherEntity extends Equatable {
  final String name, avatar, school, subject;

  const MainTeacherEntity({
    required this.name,
    required this.avatar,
    required this.school,
    required this.subject,
  });

  @override
  List<Object> get props => [name, avatar, school, subject];
}
