part of 'get_sections_cubit.dart';

abstract class GetSectionsState extends Equatable {
  const GetSectionsState();

  @override
  List<Object> get props => [];
}

class GetSectionsInitial extends GetSectionsState {}

class GetSectionsLoading extends GetSectionsState {}

class GetSectionsFailier extends GetSectionsState {
  final String errMsg;
  GetSectionsFailier(this.errMsg);
}

class GetSectionsSucess extends GetSectionsState {
  final SectionsListModel sectionsModel;
  GetSectionsSucess(this.sectionsModel);
}
