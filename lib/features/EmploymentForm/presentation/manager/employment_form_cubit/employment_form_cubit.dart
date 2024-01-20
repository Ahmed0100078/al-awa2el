import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madaresco/features/StudentApplicationForm/data/models/schools_model.dart';

import '../../../data/repo_Impl/employmentform_repo_impl.dart';

part 'employment_form_state.dart';

class EmploymentFormCubit extends Cubit<EmploymentFormState> {
  EmploymentFormCubit() : super(EmploymentFormInitial());

  static EmploymentFormCubit get(context) => BlocProvider.of(context);
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController nameController = TextEditingController();
  TextEditingController universityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController graduationDateController = TextEditingController();
  TextEditingController birthDayController = TextEditingController();
  TextEditingController ratingController = TextEditingController();
  TextEditingController maritalStatusController = TextEditingController();
  TextEditingController partnerNameController = TextEditingController();
  TextEditingController partnerBirthdateController = TextEditingController();
  TextEditingController certificateController = TextEditingController();
  TextEditingController schoolWantedController = TextEditingController();
  TextEditingController workAddressController = TextEditingController();
  TextEditingController academicAchievementController = TextEditingController();
  TextEditingController childrenCountController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController experienceYearsController = TextEditingController();
  TextEditingController experienceLocationController = TextEditingController();
  TextEditingController computerExperienceController = TextEditingController();
  TextEditingController computerProgramsController = TextEditingController();
  TextEditingController alternatePhoneNumberController =
      TextEditingController();
  TextEditingController languagesController = TextEditingController();
  TextEditingController coursesController = TextEditingController();
  TextEditingController hobbiesController = TextEditingController();
  TextEditingController thankingController = TextEditingController();

  EmploymentFormRepoImpl employmentFormRepoImpl = EmploymentFormRepoImpl();
  School? selectedSchool;
  String? gender;
  Future registerStudentForm() async {
    var body = {
      "name": nameController.text.toString(),
      "gender": gender.toString(),
      "birthdate": birthDayController.text.toString(),
      "address": addressController.text.toString(),
      "academic_achievement": academicAchievementController.text.toString(),
      "university": universityController.text.toString(),
      "department": departmentController.text.toString(),
      "graduation_date": graduationDateController.text.toString(),
      "rating": ratingController.text.toString(),
      "marital_status": maritalStatusController.text.toString(),
      "partner_name": partnerNameController.text.toString(),
      "partner_birthdate": partnerBirthdateController.text.toString(),
      "certificate": certificateController.text.toString(),
      "work_address": workAddressController.text.toString(),
      "children_count": childrenCountController.text.toString(),
      "phone": phoneController.text.toString(),
      "alternative_phone": alternatePhoneNumberController.text.toString(),
      "experience": experienceController.text.toString(),
      "experience_years": experienceYearsController.text.toString(),
      "experience_location": experienceLocationController.text.toString(),
      "computer_experience": computerExperienceController.text.toString(),
      "computer_programs": computerProgramsController.text.toString(),
      "languages": languagesController.text.toString(),
      "courses": coursesController.text.toString(),
      "hobbies": hobbiesController.text.toString(),
      "thanking": thankingController.text.toString(),
      "school_id": selectedSchool!.id.toString()
    };
    emit(EmploymentFormLoading());
    try {
      await employmentFormRepoImpl.registerEmploymentForm(body);
      emit(EmploymentFormSuccess());
    } on DioError catch (e) {
      emit(
        EmploymentFormFailier(
          e.response!.data['message'] + e.response!.data['errors'].toString(),
        ),
      );
    } on Exception {
      emit(
        EmploymentFormFailier("Error"),
      );
    }
  }
}
