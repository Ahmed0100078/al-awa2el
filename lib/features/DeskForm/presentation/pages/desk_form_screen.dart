import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:madaresco/Util/SharedPrefernce.dart';
import 'package:madaresco/core/widgets/error_dialog_widget.dart';
import 'package:madaresco/core/widgets/loader.dart';
import 'package:madaresco/core/widgets/shared_text_field.dart';
import 'package:madaresco/features/DeskForm/data/models/grades_model.dart';
import 'package:madaresco/features/DeskForm/presentation/manager/desk_form_cubit/desk_form_cubit.dart';
import 'package:madaresco/features/DeskForm/presentation/manager/grades_cubit/grades_cubit.dart';
import 'package:madaresco/features/Login/data/remote/models/login_model.dart'
    as loginModel;
import 'package:madaresco/features/OpeningScreen/OpeningScreen.dart';
import 'package:madaresco/features/SupervisorOpeningScreen/supervisor_opening_screen.dart';
import 'package:madaresco/features/TeacherOpeningScreen/teacher_opening_screen.dart';
import 'package:provider/provider.dart';
import '../../../../core/constant.dart';
import '../../../../core/language/AppLanguage.dart';
import '../../../../core/language/app_loclaizations.dart';
import '../../../../main.dart';
import '../../../StudentApplicationForm/data/models/schools_model.dart';
import '../../../StudentApplicationForm/presentation/manager/get_schools_cubit/get_schools_cubit.dart';

class DeskFormScreen extends StatefulWidget {
  DeskFormScreen({Key? key}) : super(key: key);

  @override
  State<DeskFormScreen> createState() => _DeskFormScreenState();
}

class _DeskFormScreenState extends State<DeskFormScreen> {
  String? _lang;
  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    var appLanguage = Provider.of<AppLanguage>(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GetSchoolsCubit()..getSchools()),
        BlocProvider(create: (context) => GradesCubit()),
    ],
      child: BlocConsumer<DeskFormCubit, DeskFormState>(
        listener: (context, state) {
          log(state.toString());
          if (state is DeskFormLoading) {
            Loader.start();
          }
          if (state is DeskFormSuccess) {
            Loader.stop();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => SuccesfulScreen(
                    message: 'تم تقديم الطلب بنجاح وستتم المراجعة'),
              ),
              ModalRoute.withName("/Home"),
            );
          }
          if (state is DeskFormFailier) {
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
                          local.translate('Submit_seat_form'),
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
                            key: DeskFormCubit.get(context).formKey,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                SharedTextFormField(
                                    hintText: local
                                        .translate('student_quadruple_name'),
                                    textEditingController:
                                        DeskFormCubit.get(context)
                                            .sutudentNameController),
                                SizedBox(
                                  height: 15,
                                ),
                                SharedTextFormField(
                                    hintText: local.translate('parent_name'),
                                    textEditingController:
                                        DeskFormCubit.get(context)
                                            .parentNameController),
                                SizedBox(
                                  height: 15,
                                ),
                                SharedTextFormField(
                                  hintText: local.translate('phone'),
                                  textEditingController:
                                      DeskFormCubit.get(context)
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
                                      DeskFormCubit.get(context)
                                          .alternativePhoneController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
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
                                            value: DeskFormCubit.get(context)
                                                        .selectedSchool ==
                                                    null
                                                ? null
                                                : DeskFormCubit.get(context)
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
                                                DeskFormCubit.get(context)
                                                    .selectedSchool = newValue!;
                                                GradesCubit.get(context).getGrades(newValue.id);
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
                                  height: 15.0,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      local.translate('choose_grade') +
                                          " "
                                              "السابقة",
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
                                BlocBuilder<GradesCubit, GradesState>(
                                  builder: (context, state) {
                                    if (state is GradesSuccess) {
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
                                          child: DropdownButton<Grade>(
                                            value: DeskFormCubit.get(context)
                                                        .oldGrade ==
                                                    null
                                                ? null
                                                : DeskFormCubit.get(context)
                                                    .oldGrade,
                                            hint: Text(
                                              local.translate('choose_grade'),
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
                                            onChanged: (Grade? newValue) {
                                              setState(() {
                                                DeskFormCubit.get(context)
                                                    .oldGrade = newValue!;
                                              });
                                            },
                                            items: state
                                                .gradesModel.data!.gradse!
                                                .map<DropdownMenuItem<Grade>>(
                                                    (Grade value) {
                                              return DropdownMenuItem<Grade>(
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
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      local.translate('choose_grade') +
                                          " "
                                              "القادمة",
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
                                BlocBuilder<GradesCubit, GradesState>(
                                  builder: (context, state) {
                                    if (state is GradesSuccess) {
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
                                          child: DropdownButton<Grade>(
                                            value: DeskFormCubit.get(context)
                                                        .newGrade ==
                                                    null
                                                ? null
                                                : DeskFormCubit.get(context)
                                                    .newGrade,
                                            hint: Text(
                                              local.translate('choose_grade'),
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
                                            onChanged: (Grade? newValue) {
                                              setState(() {
                                                DeskFormCubit.get(context)
                                                    .newGrade = newValue!;
                                              });
                                            },
                                            items: state
                                                .gradesModel.data!.gradse!
                                                .map<DropdownMenuItem<Grade>>(
                                                    (Grade value) {
                                              return DropdownMenuItem<Grade>(
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
                                      if (DeskFormCubit.get(context)
                                          .formKey
                                          .currentState!
                                          .validate()) {
                                        if (DeskFormCubit.get(context)
                                                    .oldGrade ==
                                                null ||
                                            DeskFormCubit.get(context)
                                                    .newGrade ==
                                                null) {
                                          showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  errorDialogWidget(
                                                      context,
                                                      local.translate(
                                                          'Please_select_the_grade')));
                                        } else if (DeskFormCubit.get(context)
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
                                          await DeskFormCubit.get(context)
                                              .registerDeskForm();
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
            height: 30.0,
          ),
          // SizedBox(
          //   width: 200,
          //   child: ElevatedButton(
          //     onPressed: () async {
          //       Navigator.of(context).pushAndRemoveUntil(
          //           MaterialPageRoute(
          //             builder: (context) => ChangeNotifierProvider(
          //               create: (_) => sl<LoginViewModel>(),
          //               child: LoginPage(),
          //             ),
          //           ),
          //           (route) => false);
          //     },
          //     style: ButtonStyle(
          //       shape: MaterialStateProperty.all<OutlinedBorder>(
          //           RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(80.0))),
          //       padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          //           const EdgeInsets.all(0.0)),
          //       textStyle: MaterialStateProperty.all<TextStyle?>(
          //           TextStyle(color: Colors.white)),
          //     ),
          //     child: Container(
          //       width: double.infinity,
          //       decoration: kBoxDecoration.copyWith(
          //           borderRadius: BorderRadius.all(Radius.circular(87.0))),
          //       child: Center(
          //           child: Text(local.translate('home'),
          //               style: TextStyle(
          //                   fontSize: 16, fontWeight: FontWeight.bold))),
          //     ),
          //   ),
          // )
        ]),
      ),
    );
  }
}
