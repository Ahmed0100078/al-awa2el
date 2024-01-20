import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madaresco/features/DeskForm/data/models/grades_model.dart';
import 'package:madaresco/features/DeskForm/data/repo_Impl/desk_form_repo_impl.dart';
part 'grades_state.dart';

class GradesCubit extends Cubit<GradesState> {
  GradesCubit() : super(GradesInitial());

  static GradesCubit get(context) => BlocProvider.of(context);
  DeskFormRepoImpl deskFormRepoImpl = DeskFormRepoImpl();
  Future getGrades(int schoolid) async {
    emit(GradesLoading());
    try {
      var response = await deskFormRepoImpl.getGrades(schoolid);
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        var data = json.decode(response.body);

        emit(GradesSuccess(GradesModel.fromJson(data)));
      } else {
        final body = json.decode(response.body);
        emit(GradesFailier(
            body['message'].toString() + '\n' + body['errors'].toString()));
      }
    } on Exception {
      emit(
        GradesFailier('error'),
      );
    }
  }
}
