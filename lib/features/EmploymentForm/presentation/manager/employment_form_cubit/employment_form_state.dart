part of 'employment_form_cubit.dart';

abstract class EmploymentFormState extends Equatable {
  const EmploymentFormState();

  @override
  List<Object> get props => [];
}

class EmploymentFormInitial extends EmploymentFormState {}

class EmploymentFormLoading extends EmploymentFormState {}

class EmploymentFormSuccess extends EmploymentFormState {}

class EmploymentFormFailier extends EmploymentFormState {
  final String errMsg;

  EmploymentFormFailier(this.errMsg);
}
