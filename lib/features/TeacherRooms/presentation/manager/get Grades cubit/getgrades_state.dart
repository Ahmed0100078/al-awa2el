part of 'getgrades_cubit.dart';

abstract class GetgradesState extends Equatable {
  const GetgradesState();

  @override
  List<Object> get props => [];
}

class GetgradesInitial extends GetgradesState {}

class GetgradesLoading extends GetgradesState {}

class GetgradesSuccess extends GetgradesState {
  final GradesListModel gradesModel;
  GetgradesSuccess(this.gradesModel);
}

class GetgradesFailier extends GetgradesState {
  final String errMsg;
  GetgradesFailier(this.errMsg);
}
