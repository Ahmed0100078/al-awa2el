import 'package:equatable/equatable.dart';

class SupervisorEntity extends Equatable {
  final String name, avatar, school, subject;

  const SupervisorEntity({
    required this.name,
    required this.avatar,
    required this.school,
    required this.subject,
  });

  @override
  List<Object> get props => [name, avatar, school, subject];
}
