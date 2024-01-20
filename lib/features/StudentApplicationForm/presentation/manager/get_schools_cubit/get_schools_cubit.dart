import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madaresco/features/StudentApplicationForm/data/models/schools_model.dart';
import '../../../data/repo_Impl/Student _application_form_repoImpl.dart';
part 'get_schools_state.dart';

class GetSchoolsCubit extends Cubit<GetSchoolsState> {
  GetSchoolsCubit() : super(GetSchoolsInitial());

  static GetSchoolsCubit get(context) => BlocProvider.of(context);
  StudentApplicationRepoImpl studentApplicationRepoImpl =
      StudentApplicationRepoImpl();
  Future getSchools() async {
    emit(GetSchoolsLoading());
    try {
      var response = await studentApplicationRepoImpl.getSchools();
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        var data = json.decode(response.body);
        // List<String> schoolIds = studentApplicationRepoImpl.getSchoolIds(response);

        emit(GetSchoolsSuccess(SchoolsModel.fromJson(data)));
      } else {
        final body = json.decode(response.body);
        emit(GetSchoolsFailier(
            body['message'].toString() + '\n' + body['errors'].toString()));
      }
    } on Exception {
      emit(
        GetSchoolsFailier('error'),
      );
    }
  }
}
