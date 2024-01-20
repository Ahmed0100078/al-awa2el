import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madaresco/features/DeskForm/data/models/grades_model.dart';
import 'package:madaresco/features/DeskForm/data/repo_Impl/desk_form_repo_impl.dart';
import 'package:madaresco/features/StudentApplicationForm/data/models/schools_model.dart';

part 'desk_form_state.dart';

class DeskFormCubit extends Cubit<DeskFormState> {
  DeskFormCubit() : super(DeskFormInitial());

  static DeskFormCubit get(context) => BlocProvider.of(context);
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController parentNameController = TextEditingController();
  TextEditingController sutudentNameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();
  TextEditingController alternativePhoneController = TextEditingController();
  Grade? oldGrade;
  Grade? newGrade;
  DeskFormRepoImpl deskFormRepoImpl = DeskFormRepoImpl();
  School? selectedSchool;

  Future registerDeskForm() async {
    var body = {
      "student_name": sutudentNameController.text.toString(),
      "parent_name": parentNameController.text.toString(),
      "phone": phoneController.text.toString(),
      "old_grade_id": oldGrade!.id.toString(),
      "new_grade_id": newGrade!.id.toString(),
      "school_id": selectedSchool!.id.toString(),
      "alternative_phone": alternativePhoneController.text.toString(),
    };
    emit(DeskFormLoading());

    try {
      await deskFormRepoImpl.registerDeskForm(body);
      emit(DeskFormSuccess());
    } on DioError catch (e) {
      emit(
        DeskFormFailier(
          e.response!.data['message'] + e.response!.data['errors'].toString(),
        ),
      );
    } on Exception {
      emit(
        DeskFormFailier("Error"),
      );
    }
  }
}
