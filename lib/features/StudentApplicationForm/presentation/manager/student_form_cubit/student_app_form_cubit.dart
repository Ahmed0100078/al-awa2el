import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madaresco/features/StudentApplicationForm/data/models/schools_model.dart';

import '../../../data/repo_Impl/Student _application_form_repoImpl.dart';

part 'student_app_form_state.dart';

class StudentAppFormCubit extends Cubit<StudentAppFormState> {
  StudentAppFormCubit() : super(StudentAppFormInitial());

  static StudentAppFormCubit get(context) => BlocProvider.of(context);
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController stNameController = TextEditingController();
  TextEditingController stBirthPlaceController = TextEditingController();
  TextEditingController stAddressController = TextEditingController();
  TextEditingController stNoOfBrothersController = TextEditingController();
  TextEditingController stIdNoController = TextEditingController();
  TextEditingController stSiblingsRankController = TextEditingController();
  TextEditingController stBirthDayController = TextEditingController();
  TextEditingController stNotesController = TextEditingController();
  TextEditingController stRegistrDateController = TextEditingController();
  TextEditingController lastSchoolController = TextEditingController();
  TextEditingController gradeWantedController = TextEditingController();
  TextEditingController lastSuccessStageController = TextEditingController();
  TextEditingController previuseStagesAvgController = TextEditingController();
  TextEditingController schoolWantedController = TextEditingController();
  TextEditingController guardianNameController = TextEditingController();
  TextEditingController guardianEducationController = TextEditingController();
  TextEditingController guardianPhoneController = TextEditingController();
  TextEditingController motherNameController = TextEditingController();
  TextEditingController motherEducationController = TextEditingController();
  TextEditingController guardianJobPositionController = TextEditingController();
  TextEditingController schoolHeNeedController = TextEditingController();
  TextEditingController isParentsAliveController =
      TextEditingController(text: "1");
  TextEditingController guardianExactProfessionController =
      TextEditingController();
  TextEditingController motherExactProfessionController =
      TextEditingController();
  TextEditingController alternatePhoneNumberController =
      TextEditingController();
  StudentApplicationRepoImpl studentApplicationRepoImpl =
      StudentApplicationRepoImpl();
  School? selectedSchool;
  Future registerStudentForm() async {
    var body = {
      "name": stNameController.text,
      "birth_location": stBirthPlaceController.text,
      "address": stAddressController.text,
      "id_number": stIdNoController.text.toString(),
      "brothers_number": stNoOfBrothersController.text.toString(),
      "brothers_ranking": stSiblingsRankController.text.toString(),
      "birthdate": stBirthDayController.text.toString(),
      "notes": stNotesController.text,
      "last_school_name": lastSchoolController.text,
      "desired_grade": gradeWantedController.text,
      "last_successed_grade": lastSuccessStageController.text,
      "last_grade_result": previuseStagesAvgController.text,
      "parent_name": guardianNameController.text,
      "parent_academic_achievement": guardianEducationController.text,
      "parent_phone": guardianPhoneController.text,
      "mother_name": motherNameController.text,
      "mother_academic_achievement": motherEducationController.text,
      "parent_job": guardianJobPositionController.text,
      "parents_alive": isParentsAliveController.text,
      "parent_job_description": guardianExactProfessionController.text,
      "mother_job_description": motherExactProfessionController.text,
      "alternative_phone": alternatePhoneNumberController.text.toString(),
      "school_id": selectedSchool!.id.toString(),
      "school_he_need": selectedSchool!.name,
    };
    emit(StudentAppFormLoading());
    log('${stBirthDayController.text}');

    try {
      await studentApplicationRepoImpl.registerStudentForm(body);
      emit(StudentAppFormSuccess());
    } on DioError catch (e) {
      emit(
        StudentAppFormFailier(
          e.response!.data['message'] + e.response!.data['errors'].toString(),
        ),
      );
    } on Exception {
      emit(
        StudentAppFormFailier("Error"),
      );
    }
  }
}
