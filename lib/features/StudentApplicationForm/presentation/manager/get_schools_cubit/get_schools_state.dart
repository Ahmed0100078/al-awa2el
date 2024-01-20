part of 'get_schools_cubit.dart';

abstract class GetSchoolsState extends Equatable {
  const GetSchoolsState();

  @override
  List<Object> get props => [];
}

class GetSchoolsInitial extends GetSchoolsState {}

class GetSchoolsLoading extends GetSchoolsState {}

class GetSchoolsSuccess extends GetSchoolsState {
  final SchoolsModel schoolModel;
  GetSchoolsSuccess(this.schoolModel);
}

class GetSchoolsFailier extends GetSchoolsState {
  final String errMsg;
  GetSchoolsFailier(this.errMsg);
}
