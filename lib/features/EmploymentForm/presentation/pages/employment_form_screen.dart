import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:madaresco/Util/SharedPrefernce.dart';
import 'package:madaresco/core/widgets/error_dialog_widget.dart';
import 'package:madaresco/core/widgets/loader.dart';
import 'package:madaresco/core/widgets/shared_text_field.dart';
import 'package:madaresco/features/EmploymentForm/presentation/manager/employment_form_cubit/employment_form_cubit.dart';
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

class EmploymentFormScreen extends StatefulWidget {
  EmploymentFormScreen({Key? key}) : super(key: key);

  @override
  State<EmploymentFormScreen> createState() => _EmploymentFormScreenState();
}

class _EmploymentFormScreenState extends State<EmploymentFormScreen> {
  String? _lang;
  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    var appLanguage = Provider.of<AppLanguage>(context);
    return BlocProvider(
      create: (context) => GetSchoolsCubit()..getSchools(),
      child: BlocConsumer<EmploymentFormCubit, EmploymentFormState>(
        listener: (context, state) {
          log(state.toString());
          if (state is EmploymentFormLoading) {
            Loader.start();
          }
          if (state is EmploymentFormSuccess) {
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
          if (state is EmploymentFormFailier) {
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
                          local.translate('Submit_employment_application'),
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
                            key: EmploymentFormCubit.get(context).formKey,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                SharedTextFormField(
                                  hintText: local.translate('name'),
                                  textEditingController:
                                      EmploymentFormCubit.get(context)
                                          .nameController,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      local.translate('gender'),
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
                                        value: EmploymentFormCubit.get(context)
                                                    .gender !=
                                                null
                                            ? EmploymentFormCubit.get(context)
                                                        .gender ==
                                                    "ذكر"
                                                ? "male"
                                                : "female"
                                            : null,
                                        //
                                        hint: Text(
                                          local.translate('gender'),
                                          style: TextStyle(
                                            color: Colors.black.withOpacity(.7),
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
                                          EmploymentFormCubit.get(context)
                                              .gender = newValue;
                                          setState(() {});
                                        },
                                        items: [
                                          DropdownMenuItem<String>(
                                            value: "male",
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.0),
                                              child: Text(
                                                local.translate('male'),
                                              ),
                                            ),
                                          ),
                                          DropdownMenuItem<String>(
                                            value: "female",
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.0),
                                              child: Text(
                                                local.translate('female'),
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
                                  hintText: local.translate('social_situation'),
                                  textEditingController:
                                      EmploymentFormCubit.get(context)
                                          .maritalStatusController,
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
                                        EmploymentFormCubit.get(context)
                                                .birthDayController
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
                                          EmploymentFormCubit.get(context)
                                                  .birthDayController
                                                  .text
                                                  .isNotEmpty
                                              ? EmploymentFormCubit.get(context)
                                                  .birthDayController
                                                  .text
                                              : "dd-MM-yyyy",
                                          style: TextStyle(
                                              color: Colors.black
                                                  .withOpacity(.7))),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SharedTextFormField(
                                  hintText: local.translate('address'),
                                  textEditingController:
                                      EmploymentFormCubit.get(context)
                                          .addressController,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SharedTextFormField(
                                  hintText:
                                      local.translate('academic_achievement'),
                                  textEditingController:
                                      EmploymentFormCubit.get(context)
                                          .academicAchievementController,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SharedTextFormField(
                                  hintText: local.translate('the_college'),
                                  textEditingController:
                                      EmploymentFormCubit.get(context)
                                          .universityController,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SharedTextFormField(
                                  hintText: local.translate('Section'),
                                  textEditingController:
                                      EmploymentFormCubit.get(context)
                                          .departmentController,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      local.translate('graduation_date'),
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
                                        EmploymentFormCubit.get(context)
                                                .graduationDateController
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
                                          EmploymentFormCubit.get(context)
                                                  .graduationDateController
                                                  .text
                                                  .isNotEmpty
                                              ? EmploymentFormCubit.get(context)
                                                  .graduationDateController
                                                  .text
                                              : "dd-MM-yyyy",
                                          style: TextStyle(
                                              color: Colors.black
                                                  .withOpacity(.7))),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SharedTextFormField(
                                  hintText: local.translate('rate'),
                                  textEditingController:
                                      EmploymentFormCubit.get(context)
                                          .ratingController,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SharedTextFormField(
                                  hintText: local.translate('partner_name'),
                                  textEditingController:
                                      EmploymentFormCubit.get(context)
                                          .partnerNameController,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SharedTextFormField(
                                  hintText: local.translate('Certificate'),
                                  textEditingController:
                                      EmploymentFormCubit.get(context)
                                          .certificateController,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SharedTextFormField(
                                  hintText: local.translate('work_address'),
                                  textEditingController:
                                      EmploymentFormCubit.get(context)
                                          .workAddressController,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SharedTextFormField(
                                  hintText:
                                      local.translate('number_of_children'),
                                  textEditingController:
                                      EmploymentFormCubit.get(context)
                                          .childrenCountController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SharedTextFormField(
                                  hintText: local.translate('phone'),
                                  textEditingController:
                                      EmploymentFormCubit.get(context)
                                          .phoneController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SharedTextFormField(
                                  hintText:
                                      local.translate('alternate_phone_number'),
                                  textEditingController:
                                      EmploymentFormCubit.get(context)
                                          .alternatePhoneNumberController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SharedTextFormField(
                                  hintText: local.translate('Experience'),
                                  textEditingController:
                                      EmploymentFormCubit.get(context)
                                          .experienceController,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SharedTextFormField(
                                  hintText:
                                      local.translate('Years_of_Experience'),
                                  textEditingController:
                                      EmploymentFormCubit.get(context)
                                          .experienceYearsController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SharedTextFormField(
                                  hintText:
                                      local.translate('place_of_experience'),
                                  textEditingController:
                                      EmploymentFormCubit.get(context)
                                          .experienceLocationController,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SharedTextFormField(
                                  hintText:
                                      local.translate('Computer_experience'),
                                  textEditingController:
                                      EmploymentFormCubit.get(context)
                                          .computerExperienceController,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SharedTextFormField(
                                  hintText:
                                      local.translate('computer_software'),
                                  textEditingController:
                                      EmploymentFormCubit.get(context)
                                          .computerProgramsController,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SharedTextFormField(
                                  hintText: local.translate('the_language'),
                                  textEditingController:
                                      EmploymentFormCubit.get(context)
                                          .languagesController,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SharedTextFormField(
                                  hintText: local.translate('courses'),
                                  textEditingController:
                                      EmploymentFormCubit.get(context)
                                          .coursesController,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SharedTextFormField(
                                  hintText: local.translate("Interests"),
                                  textEditingController:
                                      EmploymentFormCubit.get(context)
                                          .hobbiesController,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SharedTextFormField(
                                  hintText: local.translate("beliefs"),
                                  textEditingController:
                                      EmploymentFormCubit.get(context)
                                          .thankingController,
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
                                            value: (EmploymentFormCubit.get(
                                                                context)
                                                            .selectedSchool ==
                                                        null ||
                                                    !state.schoolModel.data!
                                                        .schools!
                                                        .contains(
                                                            EmploymentFormCubit
                                                                    .get(
                                                                        context)
                                                                .selectedSchool))
                                                ? null
                                                : EmploymentFormCubit.get(
                                                        context)
                                                    .selectedSchool,
                                            hint: Text(
                                              local.translate('choose_school'),
                                              style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(.7),
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
                                                EmploymentFormCubit.get(context)
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
                                SizedBox(
                                  height: 25,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 90.0),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if (EmploymentFormCubit.get(context)
                                          .formKey
                                          .currentState!
                                          .validate()) {
                                        if (EmploymentFormCubit.get(context)
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
                                          await EmploymentFormCubit.get(context)
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
