import 'package:equatable/equatable.dart';

class LoginData extends Equatable {
  final String ?name;
  final String ?type;
  final String ?token;
  final String ?email;
  final String ?userType;
  final bool ?isActive;

  LoginData(
      {this.name,
      this.type,
      this.token,
      this.isActive,
      this.email,
      this.userType});

  @override
  List<Object> get props => [name!, type!, token!, isActive!];
}
