part of 'grades_cubit.dart';

abstract class GradesState extends Equatable {
  const GradesState();

  @override
  List<Object> get props => [];
}

class GradesInitial extends GradesState {}

class GradesLoading extends GradesState {}

class GradesSuccess extends GradesState {
  final GradesModel gradesModel;

  GradesSuccess(this.gradesModel);
}

class GradesFailier extends GradesState {
  final String errMsg;

  GradesFailier(this.errMsg);
}
