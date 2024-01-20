part of 'desk_form_cubit.dart';

abstract class DeskFormState extends Equatable {
  const DeskFormState();

  @override
  List<Object> get props => [];
}

class DeskFormInitial extends DeskFormState {}
class DeskFormLoading extends DeskFormState {}

class DeskFormSuccess extends DeskFormState {}

class DeskFormFailier extends DeskFormState {
  final String errMsg;

  DeskFormFailier(this.errMsg);
}