import 'package:flutter/material.dart';
import 'package:madaresco/core/constant.dart';
import 'package:madaresco/core/language/AppLanguage.dart';
import 'package:madaresco/core/language/app_loclaizations.dart';
import 'package:madaresco/features/Register/presentation/manager/register_view_model.dart';
import 'package:madaresco/features/Register/presentation/pages/succesful_registration.dart';
import 'package:madaresco/features/Register/presentation/widgets/register_school.dart';
import 'package:madaresco/features/Register/presentation/widgets/register_student.dart';
import 'package:madaresco/features/Register/presentation/widgets/register_teacher.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? _lang;

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    RegisterViewModel vm = Provider.of<RegisterViewModel>(context);
    var appLanguage = Provider.of<AppLanguage>(context);
    vm.navigateTo.addListener(() {
      if (vm.navigateTo.value.getContentIfNotHandled() != null) {
        if (vm.navigateTo.value.peekContent() == 'Student') {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  SuccesfulRegistration(message: 'student_message'),
            ),
            ModalRoute.withName("/Home"),
          );
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  SuccesfulRegistration(message: 'school_message'),
            ),
            ModalRoute.withName("/Home"),
          );
        }
      }
    });
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: vm.loading,
        builder: (context, bool loading, child) {
          return ModalProgressHUD(
            inAsyncCall: loading,
            child: child!,
          );
        },
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 36,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: PopupMenuButton<String>(
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
                          borderRadius: BorderRadius.circular(16.0)),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: Colors.black)),
                        padding: EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 10.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(Icons.arrow_drop_down,
                                color: kAccentColor, size: 35),
                            Text(
                              _lang ??
                                  (appLanguage.appLocal != Locale("ar")
                                      ? 'en'
                                      : 'العربية'),
                              style: TextStyle(
                                  color: kAccentColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      initialValue: appLanguage.appLocal != Locale("ar")
                          ? appLanguage.appLocal != Locale("ku")
                              ? 'en'
                              : 'Kurdî'
                          : 'العربية',
                      itemBuilder: (context) => ['en', 'العربية', 'Kurdî']
                          .map<PopupMenuEntry<String>>((String value) {
                        return PopupMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(value),
                          ),
                        );
                      }).toList(),
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            vm.registerType = RegisterType.SCHOOL;
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: vm.registerType == RegisterType.SCHOOL
                                      ? Colors.grey.shade50
                                      : Colors.white,
                                  borderRadius:
                                      vm.registerType == RegisterType.SCHOOL
                                          ? BorderRadius.only(
                                              topLeft: Radius.circular(16.0),
                                              topRight: Radius.circular(16.0))
                                          : BorderRadius.zero),
                              child: Column(
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/school3.png',
                                    width: 60,
                                    height: 60,
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    local.translate('school'),
                                    style: TextStyle(
                                        color: kAccentColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            vm.registerType = RegisterType.TEACHER;
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: vm.registerType == RegisterType.TEACHER
                                      ? Colors.grey.shade50
                                      : Colors.white,
                                  borderRadius:
                                      vm.registerType == RegisterType.TEACHER
                                          ? BorderRadius.only(
                                              topLeft: Radius.circular(16.0),
                                              topRight: Radius.circular(16.0))
                                          : BorderRadius.zero),
                              child: Column(
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/teacher.png',
                                    width: 60,
                                    height: 60,
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    local.translate('teacher'),
                                    style: TextStyle(
                                        color: kAccentColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            vm.registerType = RegisterType.STUDENT;
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: vm.registerType == RegisterType.STUDENT
                                    ? Colors.grey.shade50
                                    : Colors.white,
                                borderRadius:
                                    vm.registerType == RegisterType.STUDENT
                                        ? BorderRadius.only(
                                            topLeft: Radius.circular(16.0),
                                            topRight: Radius.circular(16.0))
                                        : BorderRadius.zero),
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/school.png',
                                  width: 60,
                                  height: 60,
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  local.translate('student'),
                                  style: TextStyle(
                                      color: kAccentColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  padding: EdgeInsets.all(20.0),
                  child: getView(local, vm),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void hidekeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  Widget getView(AppLocalizations local, RegisterViewModel vm) {
    switch (vm.registerType) {
      case RegisterType.TEACHER:
        return RegisterTeacher();
      case RegisterType.STUDENT:
        return RegisterStudent();
      case RegisterType.SCHOOL:
        return RegisterSchool();
      default:
        return RegisterStudent();
    }
  }
}
