import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:madaresco/Util/SharedPrefernce.dart';
import 'package:madaresco/core/widgets/error_dialog_widget.dart';
import 'package:madaresco/core/widgets/loader.dart';
import 'package:madaresco/core/widgets/shared_text_field.dart';
import 'package:madaresco/features/Login/data/remote/models/login_model.dart'
    as loginModel;
import 'package:madaresco/features/OpeningScreen/OpeningScreen.dart';
import 'package:madaresco/features/StudentApplicationForm/data/models/schools_model.dart';
import 'package:madaresco/features/StudentApplicationForm/presentation/manager/get_schools_cubit/get_schools_cubit.dart';
import 'package:madaresco/features/SupervisorOpeningScreen/supervisor_opening_screen.dart';
import 'package:madaresco/features/TeacherOpeningScreen/teacher_opening_screen.dart';
import 'package:provider/provider.dart';
import '../../../../core/constant.dart';
import '../../../../core/language/AppLanguage.dart';
import '../../../../core/language/app_loclaizations.dart';
import '../../../../main.dart';
import '../manager/student_form_cubit/student_app_form_cubit.dart';

class StudentApplicationFormScreen extends StatefulWidget {
  StudentApplicationFormScreen({Key? key}) : super(key: key);

  @override
  State<StudentApplicationFormScreen> createState() =>
      _StudentApplicationFormScreenState();
}

class _StudentApplicationFormScreenState
    extends State<StudentApplicationFormScreen> {
  String? _lang;
  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    var appLanguage = Provider.of<AppLanguage>(context);
    return BlocProvider(
      create: (context) => GetSchoolsCubit()..getSchools(),
      child: BlocConsumer<StudentAppFormCubit, StudentAppFormState>(
        listener: (context, state) {
          log(state.toString());
          if (state is StudentAppFormLoading) {
            Loader.start();
          }
          if (state is StudentAppFormSuccess) {
            Loader.stop();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => SuccesfulScreen(
                    message: local.translate('success_message')),
              ),
              ModalRoute.withName("/Home"),
            );
          }
          if (state is StudentAppFormFailier) {
            Loader.stop();

            showDialog(
                context: context,
                builder: (context) => errorDialogWidget(context, state.errMsg));
          }
        },
        builder: (context, state) {
          return Scaffold(
              body: SingleChildScrollView(
                  child: Container(
                      color: Colors.white,
                      child: Column(children: <Widget>[
                        SizedBox(
                          height: 36,
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        try {
                                          mainNavigatorKey.currentState!.pop();
                                        } catch (e) {
                                          mainNavigatorKey.currentState!.pop();
                                        }
                                      },
                                      child: Icon(Icons.arrow_back_ios),
                                    )),
                                PopupMenuButton<String>(
                                  onSelected: (value) {
                                    _lang = value;
                                    setState(() {});
                                    if (value == 'العربية' &&
                                        appLanguage.appLocal != Locale("ar")) {
                                      appLanguage.changeLanguage(Locale("ar"));
                                    } else if (value == 'en' &&
                                        appLanguage.appLocal != Locale("en")) {
                                      appLanguage.changeLanguage(Locale("en"));
                                    } else if (value == 'Kurdî' &&
                                        appLanguage.appLocal != Locale("ku")) {
                                      appLanguage.changeLanguage(Locale("ku"));
                                    }
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(16.0)),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border:
                                            Border.all(color: Colors.black)),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 2.0, horizontal: 10.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Icon(Icons.arrow_drop_down,
                                            color: kAccentColor, size: 35),
                                        Text(
                                          _lang ??
                                              (appLanguage.appLocal !=
                                                      Locale("ar")
                                                  ? 'en'
                                                  : 'العربية'),
                                          style: TextStyle(
                                              color: kAccentColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  initialValue:
                                      appLanguage.appLocal != Locale("ar")
                                          ? appLanguage.appLocal != Locale("ku")
                                              ? 'en'
                                              : 'Kurdî'
                                          : 'العربية',
                                  itemBuilder: (context) => [
                                    'en',
                                    'العربية',
                                    'Kurdî'
                                  ].map<PopupMenuEntry<String>>((String value) {
                                    return PopupMenuItem<String>(
                                      value: value,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(value),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Image.asset(
                          'assets/images/door.png',
                          width: 130,
                          height: 130,
                        ),
                        SizedBox(
                          height: 26,
                        ),
                        Text(
                          local.translate('Student_application_form'),
                          style: TextStyle(
                              color: Color(0xFF001068),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          padding: EdgeInsets.all(20.0),
                          child: Form(
                            key: StudentAppFormCubit.get(context).formKey,
                            child: Column(
                              children: [
                                Align(
                                  alignment: local.locale == Locale('ar', '')
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: Text(
                                    local.translate('student_Information'),
                                    style: TextStyle(
                                        color: Color(0xFF001068),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SharedTextFormField(
                                  hintText:
                                      local.translate('student_quadruple_name'),
                                  textEditingController:
                                      StudentAppFormCubit.get(context)
                                          .stNameController,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SharedTextFormField(
                                  hintText:
                                      local.translate('Student_birthplace'),
                                  textEditingController:
                                      StudentAppFormCubit.get(context)
                                          .stBirthPlaceController,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SharedTextFormField(
                                  hintText: local.translate('address'),
                                  textEditingController:
                                      StudentAppFormCubit.get(context)
                                          .stAddressController,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SharedTextFormField(
                                  hintText:
                                      local.translate('number_of_brothers'),
                                  textEditingController:
                                      StudentAppFormCubit.get(context)
                                          .stNoOfBrothersController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SharedTextFormField(
                                  hintText: local.translate('identity_number'),
                                  validator: (v) {
                                    return;
                                  },
                                  textEditingController:
                                      StudentAppFormCubit.get(context)
                                          .stIdNoController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SharedTextFormField(
                                  hintText: local.translate(
                                      'his_arrangement_among_brothers'),
                                  textEditingController:
                                      StudentAppFormCubit.get(context)
                                          .stSiblingsRankController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SharedTextFormField(
                                  hintText: local.translate(
                                      'Chronic_diseases_observations'),
                                  textEditingController:
                                      StudentAppFormCubit.get(context)
                                          .stNotesController,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      local.translate('birth_date'),
                                      style: TextStyle(
                                          color: Color(0xFF001068),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                InkWell(
                                  onTap: () async {
                                    final picked = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.parse('1880-01-01'),
                                      firstDate: DateTime.parse('1880-01-01'),
                                      lastDate: DateTime.parse(
                                          DateTime.now().toString()),
                                    );
                                    log(picked.toString());
                                    if (picked != null) {
                                      setState(() {
                                        StudentAppFormCubit.get(context)
                                                .stBirthDayController
                                                .text =
                                            picked.toString().substring(0, 10);
                                      });
                                    }
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 60,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(26)),
                                    child: Center(
                                      child: Text(
                                          StudentAppFormCubit.get(context)
                                                  .stBirthDayController
                                                  .text
                                                  .isNotEmpty
                                              ? StudentAppFormCubit.get(context)
                                                  .stBirthDayController
                                                  .text
                                              : "dd-MM-yyyy",
                                          style: TextStyle(color: Colors.grey)),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      local.translate('schoole_info'),
                                      style: TextStyle(
                                          color: Color(0xFF001068),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SharedTextFormField(
                                  hintText: local.translate('last_school'),
                                  textEditingController:
                                      StudentAppFormCubit.get(context)
                                          .lastSchoolController,
                                ),
                                // SizedBox(
                                //   height: 15,
                                // ),
                                // SharedTextFormField(
                                //   hintText: local.translate('school_he_need'),
                                //   textEditingController:
                                //       StudentAppFormCubit.get(context)
                                //           .schoolHeNeedController,
                                // ),
                                SizedBox(
                                  height: 15,
                                ),
                                SharedTextFormField(
                                  hintText: local.translate('grade_wanted'),
                                  textEditingController:
                                      StudentAppFormCubit.get(context)
                                          .gradeWantedController,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SharedTextFormField(
                                  hintText:
                                      local.translate('last_stage_succeeded'),
                                  textEditingController:
                                      StudentAppFormCubit.get(context)
                                          .lastSuccessStageController,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SharedTextFormField(
                                  hintText: local
                                      .translate('Previous_grades_average'),
                                  textEditingController:
                                      StudentAppFormCubit.get(context)
                                          .previuseStagesAvgController,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      local.translate('choose_school'),
                                      style: TextStyle(
                                        color: kAccentColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                BlocBuilder<GetSchoolsCubit, GetSchoolsState>(
                                  builder: (context, state) {
                                    if (state is GetSchoolsSuccess) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(26.0),
                                          border:
                                              Border.all(color: Colors.grey),
                                        ),
                                        height: 50,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Center(
                                          child: DropdownButton<School>(
                                            value:
                                                StudentAppFormCubit.get(context)
                                                            .selectedSchool ==
                                                        null
                                                    ? null
                                                    : StudentAppFormCubit.get(
                                                            context)
                                                        .selectedSchool,
                                            hint: Text(
                                              local.translate('choose_school'),
                                              style: TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                            underline: Container(),
                                            icon: Icon(
                                              Icons.arrow_drop_down,
                                              color: Colors.black,
                                            ),
                                            iconSize: 30,
                                            style:
                                                TextStyle(color: Colors.black),
                                            isExpanded: true,
                                            onChanged: (School? newValue) {
                                              setState(() {
                                                StudentAppFormCubit.get(context)
                                                    .selectedSchool = newValue!;
                                              });
                                            },
                                            items: state
                                                .schoolModel.data!.schools!
                                                .map<DropdownMenuItem<School>>(
                                                    (School value) {
                                              return DropdownMenuItem<School>(
                                                value: value,
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                                  child: Text(value.name!),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return SizedBox();
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      local.translate('parent_info'),
                                      style: TextStyle(
                                          color: Color(0xFF001068),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SharedTextFormField(
                                  hintText: local.translate('parent_name'),
                                  textEditingController:
                                      StudentAppFormCubit.get(context)
                                          .guardianNameController,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SharedTextFormField(
                                  hintText: local
                                      .translate('parent_academic_chievement'),
                                  textEditingController:
                                      StudentAppFormCubit.get(context)
                                          .guardianEducationController,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SharedTextFormField(
                                  hintText: local.translate('parent_phone'),
                                  textEditingController:
                                      StudentAppFormCubit.get(context)
                                          .guardianPhoneController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SharedTextFormField(
                                  hintText: local.translate('mother_name'),
                                  textEditingController:
                                      StudentAppFormCubit.get(context)
                                          .motherNameController,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SharedTextFormField(
                                  hintText: local
                                      .translate('mother_academic_chievement'),
                                  textEditingController:
                                      StudentAppFormCubit.get(context)
                                          .motherEducationController,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SharedTextFormField(
                                  hintText:
                                      local.translate('guardian_job_position'),
                                  textEditingController:
                                      StudentAppFormCubit.get(context)
                                          .guardianJobPositionController,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      local.translate('are_parents_alive'),
                                      style: TextStyle(
                                          color: Color(0xFF001068),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(26.0),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  height: 50,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Center(
                                    child: DropdownButton<String>(
                                        value: StudentAppFormCubit.get(context)
                                                .isParentsAliveController
                                                .text
                                                .isNotEmpty
                                            ? StudentAppFormCubit.get(context)
                                                .isParentsAliveController
                                                .text
                                            : "1",
                                        hint: Text(
                                          local.translate('yes_no'),
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        underline: Container(),
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.black,
                                        ),
                                        iconSize: 30,
                                        style: TextStyle(color: Colors.black),
                                        isExpanded: true,
                                        onChanged: (String? newValue) {
                                          StudentAppFormCubit.get(context)
                                              .isParentsAliveController
                                              .text = newValue!;
                                        },
                                        items: [
                                          DropdownMenuItem<String>(
                                            value: "1",
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.0),
                                              child: Text(
                                                local.translate('yes'),
                                              ),
                                            ),
                                          ),
                                          DropdownMenuItem<String>(
                                            value: "0",
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.0),
                                              child: Text(
                                                local.translate('no'),
                                              ),
                                            ),
                                          )
                                        ]),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SharedTextFormField(
                                  hintText: local.translate(
                                      'guardian_delicate_Occupation'),
                                  textEditingController:
                                      StudentAppFormCubit.get(context)
                                          .guardianExactProfessionController,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SharedTextFormField(
                                  hintText: local
                                      .translate('mother_delicate_Occupation'),
                                  textEditingController:
                                      StudentAppFormCubit.get(context)
                                          .motherExactProfessionController,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SharedTextFormField(
                                  hintText:
                                      local.translate('alternate_phone_number'),
                                  textEditingController:
                                      StudentAppFormCubit.get(context)
                                          .alternatePhoneNumberController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 90.0),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if (StudentAppFormCubit.get(context)
                                          .formKey
                                          .currentState!
                                          .validate()) {
                                        if (StudentAppFormCubit.get(context)
                                                .selectedSchool ==
                                            null) {
                                          showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  errorDialogWidget(
                                                      context,
                                                      local.translate(
                                                          'please_choose_school')));
                                        } else {
                                          await StudentAppFormCubit.get(context)
                                              .registerStudentForm();
                                        }
                                      }
                                    },
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              OutlinedBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(80.0))),
                                      padding: MaterialStateProperty.all<
                                              EdgeInsetsGeometry>(
                                          const EdgeInsets.all(0.0)),
                                      textStyle:
                                          MaterialStateProperty.all<TextStyle?>(
                                              TextStyle(color: Colors.white)),
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: kBoxDecoration.copyWith(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(87.0))),
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 10, 20, 10),
                                      child: Center(
                                          child: Text(
                                              local.translate('register'),
                                              style: TextStyle(fontSize: 20))),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]))));
        },
      ),
    );
  }

  // Future _showDatePicker(context) async {
  //   showDatePicker(
  //       context: context,
  //       initialDate: DateTime.parse('1880-01-01'),
  //       firstDate: DateTime.parse('1880-01-01'),
  //       lastDate: DateTime.parse(DateTime.now().toString()),
  //       selectableDayPredicate: (dateTime) {
  //         StudentAppFormCubit.get(context).stBirthDayController.text =
  //             dateTime.toString().substring(0, 10);
  //         return true;
  //       });
  // }
}

class SuccesfulScreen extends StatefulWidget {
  final String _message;

  const SuccesfulScreen({
    required String message,
  }) : _message = message;

  @override
  State<SuccesfulScreen> createState() => _SuccesfulScreenState();
}

class _SuccesfulScreenState extends State<SuccesfulScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4), () async {
      loginModel.LoginModel? model;
      model = await SharedPreference.getLoginModel();
      if (model!.type == 'teacher') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => TeacherOpeningScreen()),
        );
      } else if (model.type == "supervisor") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => SuperVisorOpeningScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => OpeningScreen()),
        );
      }
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (_) => ChangeNotifierProvider(
      //       create: (_) => sl<LoginViewModel>(),
      //       child: LoginPage(),
      //     ),
      //   ),
      // );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var local = AppLocalizations.of(context);
    return Material(
      child: Container(
        color: Colors.grey.shade50,
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Lottie.asset('assets/lotti/success.json', repeat: false),
          SizedBox(
            height: 16,
          ),
          Text(
            widget._message,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10.0,
          ),
        ]),
      ),
    );
  }
}
