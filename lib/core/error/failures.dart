import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? errMSg;
  const Failure([List properties = const <dynamic>[], this.errMSg]) : super();
}

class ServerFailure extends Failure {
  final String? errMSg;
  ServerFailure({this.errMSg});
  @override
  List<Object> get props => [errMSg?? 'something went wrong'];
}

class CacheFailure extends Failure {
  @override
  List<Object> get props => [];
}

class AuthFailure extends Failure {
  @override
  List<Object> get props => [];
}
