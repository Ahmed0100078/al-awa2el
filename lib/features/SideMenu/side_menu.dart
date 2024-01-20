import 'package:flutter/material.dart';
import 'package:madaresco/Util/SharedPrefernce.dart';
import 'package:madaresco/core/language/app_loclaizations.dart';
import 'package:madaresco/features/AboutApp/presentation/manager/about_app_view_model.dart';
import 'package:madaresco/features/AboutApp/presentation/pages/about_app_page.dart';
import 'package:madaresco/features/DeskForm/presentation/pages/desk_form_screen.dart';
import 'package:madaresco/features/EmploymentForm/presentation/pages/employment_form_screen.dart';
import 'package:madaresco/features/Login/data/remote/data_sources/login_remote_datasource.dart';
import 'package:madaresco/features/Login/data/remote/models/login_model.dart';
import 'package:madaresco/features/Login/presentation/manager/LoginViewModel.dart';
import 'package:madaresco/features/Login/presentation/pages/login_page.dart';
import 'package:madaresco/features/MyProfile/presentation/manager/my_profile_view_model.dart';
import 'package:madaresco/features/MyProfile/presentation/pages/my_profile_page.dart';
import 'package:madaresco/features/Notifications/presentation/manager/notifications_view_model.dart';
import 'package:madaresco/features/Notifications/presentation/pages/notifications_page.dart';
import 'package:madaresco/features/SideMenu/change_language_dialog.dart';
import 'package:madaresco/features/SideMenu/side_menu_row.dart';
import 'package:madaresco/features/Supervisor/presentation/pages/father_page.dart';
import 'package:madaresco/injection_container.dart';
import 'package:madaresco/main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../StudentApplicationForm/presentation/pages/Student _application_form_screen.dart';

class SideMenu extends StatefulWidget {
  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  LoginModel? model;
  bool isParent = false;
  bool isStudent = false;
  bool isTeacher = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    AboutAppViewModel vm = Provider.of<AboutAppViewModel>(context);
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            bottomLeft: Radius.circular(20.0),
          ),
        ),
        width: MediaQuery.of(context).size.width * 3 / 4,
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                ),
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF001068),
                    Color(0xFF001068),
                  ],
                ),
              ),
              padding: EdgeInsets.all(20.0),
              child: Row(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    padding: EdgeInsets.all(2.0),
                    child: CircleAvatar(
                      radius: 35,
                      backgroundImage: (model?.data?.avatar) == null ||
                              (model?.data?.avatar)!.isEmpty
                          ? AssetImage('assets/images/user2.png')
                              as ImageProvider
                          : NetworkImage((model?.data?.avatar)!),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        local.translate('welcome') + ": ${model?.name ?? ''}",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        model?.data?.school?.name ?? '',
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SideMenuRow(
                      title: 'edit_profile',
                      image: 'user.png',
                      onPressed: () {
                        Navigator.of(context).pop();
                        mainNavigatorKey.currentState!.push(
                          MaterialPageRoute(
                            builder: (_) => ChangeNotifierProvider(
                              create: (_) => sl<MyProfileViewModel>(),
                              child: MyProfilePage(),
                            ),
                          ),
                        );
                      },
                    ),
                    SideMenuRow(
                      title: 'notifications',
                      image: 'alarm.png',
                      onPressed: () {
                        Navigator.of(context).pop();
                        mainNavigatorKey.currentState!.push(
                          MaterialPageRoute(
                            builder: (_) => ChangeNotifierProvider(
                              create: (_) => sl<NotificationsViewModel>(),
                              child: NotificationsPage(),
                            ),
                          ),
                        );
                      },
                    ),
                    SideMenuRow(
                      title: 'change_lang',
                      image: 'global.png',
                      onPressed: () async {
                        Dialog alertDialog = Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.0)),
                            ),
                            child: ChangeLanguageDialog());
                        await showGeneralDialog(
                            barrierColor: Colors.black.withOpacity(0.5),
                            transitionBuilder: (context, a1, a2, widget) {
                              return ScaleTransition(
                                  scale: a1, child: alertDialog);
                            },
                            transitionDuration: Duration(milliseconds: 250),
                            barrierDismissible: true,
                            barrierLabel: '',
                            context: context,
                            // ignore: missing_return
                            pageBuilder: (context, animation1, animation2) {
                              return SizedBox();
                            });
                      },
                    ),
                    SideMenuRow(
                      title: 'about_app',
                      image: 'info.png',
                      onPressed: () {
                        Navigator.of(context).pop();
                        mainNavigatorKey.currentState!.push(
                          MaterialPageRoute(
                            builder: (_) => ChangeNotifierProvider(
                              create: (_) => sl<AboutAppViewModel>(),
                              child: AboutAppPage(),
                            ),
                          ),
                        );
                      },
                    ),
                    SideMenuRow(
                      title: 'Student_application_form',
                      image: 'clipboard.png',
                      onPressed: () {
                        Navigator.of(context).pop();
                        mainNavigatorKey.currentState!.push(
                          MaterialPageRoute(
                            builder: (_) => StudentApplicationFormScreen(),
                          ),
                        );
                      },
                    ),
                    SideMenuRow(
                      title: 'Submit_employment_application',
                      image: 'clipboard.png',
                      onPressed: () {
                        Navigator.of(context).pop();
                        mainNavigatorKey.currentState!.push(
                          MaterialPageRoute(
                            builder: (_) => EmploymentFormScreen(),
                          ),
                        );
                      },
                    ),
                    SideMenuRow(
                      title: 'Submit_seat_form',
                      image: 'clipboard.png',
                      onPressed: () {
                        Navigator.of(context).pop();
                        mainNavigatorKey.currentState!.push(
                          MaterialPageRoute(
                            builder: (_) => DeskFormScreen(),
                          ),
                        );
                      },
                    ),
                    isParent
                        ? SideMenuRow(
                            title: 'backToparent',
                            image: 'backArrow.png',
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FatherPage()),
                              );
                            },
                          )
                        : SideMenuRow(
                            title: 'log_out',
                            image: 'arrow.png',
                            onPressed: () {
                              if (model != null)
                                SharedPreference.clearSharedPrefrence();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChangeNotifierProvider(
                                    create: (_) => sl<LoginViewModel>(),
                                    child: LoginPage(),
                                  ),
                                ),
                              );
                            },
                          ),
                    Visibility(
                      visible: vm.entity.showDeleteProfile == "1",
                      child: SideMenuRow(
                        title: 'delete_account',
                        image: 'bin.png',
                        onPressed: () {
                          sl<LoginRemoteDataSource>().deleteStudentAccount();
                          SharedPreference.clearSharedPrefrence();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChangeNotifierProvider(
                                create: (_) => sl<LoginViewModel>(),
                                child: LoginPage(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void getData() async {
    model = await SharedPreference.getLoginModel();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cToken = prefs.getString("Ctoken");
    isParent = cToken != null ? true : false;
    isStudent = model!.type == "student";
    setState(() {});
  }
}
