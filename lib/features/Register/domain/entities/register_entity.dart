import 'package:equatable/equatable.dart';

class RegisterEntity extends Equatable {
  final String name, token, section, school;

  const RegisterEntity({
    required this.name,
    required this.token,
    required this.section,
    required this.school,
  });

  @override
  List<Object> get props => [name, token, section, school];
}
