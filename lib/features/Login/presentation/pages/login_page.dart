import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:madaresco/core/constant.dart';
import 'package:madaresco/core/language/AppLanguage.dart';
import 'package:madaresco/core/language/app_loclaizations.dart';
import 'package:madaresco/features/DeskForm/presentation/pages/desk_form_screen.dart';
import 'package:madaresco/features/EmploymentForm/presentation/pages/employment_form_screen.dart';
import 'package:madaresco/features/Login/presentation/manager/LoginViewModel.dart';
import 'package:madaresco/features/OpeningScreen/OpeningScreen.dart';
import 'package:madaresco/features/Register/presentation/manager/register_view_model.dart';
import 'package:madaresco/features/Register/presentation/pages/register_page.dart';
import 'package:madaresco/features/Register/presentation/pages/succesful_registration.dart';
import 'package:madaresco/features/Supervisor/presentation/pages/father_page.dart';
import 'package:madaresco/features/TeacherOpeningScreen/teacher_opening_screen.dart';
import 'package:madaresco/injection_container.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../../StudentApplicationForm/presentation/pages/Student _application_form_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _formKey = GlobalKey();
  String? _lang;
  bool _teacher = false;
  bool _parent = false;

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    var appLanguage = Provider.of<AppLanguage>(context);
    LoginViewModel vm = Provider.of<LoginViewModel>(context);
    vm.navigateTo.addListener(() {
      if (vm.navigateTo.value.getContentIfNotHandled() != null) {
        if (vm.navigateTo.value.peekContent() == 'Main') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => OpeningScreen()),
          );
        } else if (vm.navigateTo.value.peekContent() == 'MainTeacher') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => TeacherOpeningScreen()),
          );
        } else if (vm.navigateTo.value.peekContent() == 'FatherPage') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => FatherPage()),
          );
        } else if (vm.navigateTo.value.peekContent() == 'success') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) =>
                    SuccesfulRegistration(message: 'student_message')),
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
            child: Form(
              key: _formKey,
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
                    'assets/images/finger.png',
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
                              _teacher = false;
                              _parent = false;
                              vm.type = "Main";
                              setState(() {});
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: !_teacher && !_parent
                                      ? Colors.grey.shade50
                                      : Colors.white,
                                  borderRadius: !_teacher
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
                        Expanded(
                          child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              _teacher = true;
                              _parent = false;
                              vm.type = "teacher";
                              setState(() {});
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: _teacher
                                        ? Colors.grey.shade50
                                        : Colors.white,
                                    borderRadius: _teacher
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
                              _parent = true;
                              _teacher = false;
                              vm.type = "supervisor";
                              setState(() {});
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: _parent
                                        ? Colors.grey.shade50
                                        : Colors.white,
                                    borderRadius: _teacher
                                        ? BorderRadius.only(
                                            topLeft: Radius.circular(16.0),
                                            topRight: Radius.circular(16.0))
                                        : BorderRadius.zero),
                                child: Column(
                                  children: <Widget>[
                                    Image.asset(
                                      'assets/images/family.png',
                                      width: 60,
                                      height: 60,
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Text(
                                      local.translate('parent'),
                                      style: TextStyle(
                                          color: kAccentColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(
                          height: 26.0,
                        ),
                        _parent
                            ? Container()
                            : TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return local.translate('school_code_error');
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  vm.schoolCode = value;
                                },
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 10.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(26.0),
                                        borderSide:
                                            BorderSide(color: Colors.grey)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(26.0),
                                        borderSide:
                                            BorderSide(color: Colors.grey)),
                                    hintText: local.translate('school_code'),
                                    hintStyle: TextStyle(
                                        color: Colors.black.withOpacity(.7))),
                              ),
                        SizedBox(
                          height: 16.0,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (_parent == true) {
                              if (EmailValidator.validate(value!) == false) {
                                return local.translate('email_error');
                              }
                            }
                            if (value!.isEmpty) {
                              return local.translate('uname_error');
                            }
                            return null;
                          },
                          onChanged: (value) {
                            if (_parent) {
                              vm.email = value;
                            } else {
                              vm.userCode = value;
                            }
                          },
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 10.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(26.0),
                                  borderSide: BorderSide(color: Colors.grey)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(26.0),
                                  borderSide: BorderSide(color: Colors.grey)),
                              hintText: _parent
                                  ? local.translate('email')
                                  : local.translate('user_name'),
                              hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(.7))),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return local.translate('pass_error');
                            }
                            return null;
                          },
                          onChanged: (value) {
                            vm.password = value;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(26.0),
                                borderSide: BorderSide(color: Colors.grey)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(26.0),
                                borderSide: BorderSide(color: Colors.grey)),
                            hintText: local.translate('pass'),
                            hintStyle:
                                TextStyle(color: Colors.black.withOpacity(.7)),
                          ),
                          obscureText: true,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 90.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          vm.onLoginClicked();
                        }
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(80.0))),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.all(0.0)),
                        textStyle: MaterialStateProperty.all<TextStyle?>(
                            TextStyle(color: Colors.white)),
                      ),
                      child: Container(
                        width: double.infinity,
                        decoration: kBoxDecoration.copyWith(
                            borderRadius:
                                BorderRadius.all(Radius.circular(87.0))),
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Center(
                            child: Text(local.translate('login'),
                                style: TextStyle(fontSize: 20))),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChangeNotifierProvider(
                            create: (_) => sl<RegisterViewModel>(),
                            child: RegisterPage(),
                          ),
                        ),
                      );
                    },
                    child: Text(
                      local.translate('new_register') + " >>",
                      style: TextStyle(color: kAccentColor),
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  if (!_parent && !_teacher)
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => StudentApplicationFormScreen(),
                          ),
                        );
                      },
                      child: Text(
                        local.translate('Student_application_form') + " >>",
                        style: TextStyle(color: kAccentColor),
                      ),
                    ),
                  if (_teacher)
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EmploymentFormScreen(),
                          ),
                        );
                      },
                      child: Text(
                        local.translate('Submit_employment_application') +
                            " >>",
                        style: TextStyle(color: kAccentColor),
                      ),
                    ),
                  if (_parent)
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DeskFormScreen(),
                          ),
                        );
                      },
                      child: Text(
                        local.translate('Submit_seat_form') + " >>",
                        style: TextStyle(color: kAccentColor),
                      ),
                    ),
                ],
              ),
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
}
