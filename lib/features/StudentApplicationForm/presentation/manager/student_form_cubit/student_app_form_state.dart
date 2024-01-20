part of 'student_app_form_cubit.dart';

abstract class StudentAppFormState extends Equatable {
  const StudentAppFormState();

  @override
  List<Object> get props => [];
}

class StudentAppFormInitial extends StudentAppFormState {}

class StudentAppFormLoading extends StudentAppFormState {}

class StudentAppFormSuccess extends StudentAppFormState {}

class StudentAppFormFailier extends StudentAppFormState {
  final String errMsg;

  StudentAppFormFailier(this.errMsg);
}
