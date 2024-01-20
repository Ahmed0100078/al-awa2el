part of 'getfilterdstudents_cubit.dart';

abstract class GetfilterdstudentsState extends Equatable {
  const GetfilterdstudentsState();

  @override
  List<Object> get props => [];
}

class GetfilterdstudentsInitial extends GetfilterdstudentsState {}

class GetfilterdstudentsLoading extends GetfilterdstudentsState {}

class GetfilterdstudentsFailier extends GetfilterdstudentsState {
  final String errMsg;
  GetfilterdstudentsFailier(this.errMsg);
}

class GetfilterdstudentsSuccess extends GetfilterdstudentsState {
  final FilteredStudentsModels studentModel;
  GetfilterdstudentsSuccess(this.studentModel);
}
