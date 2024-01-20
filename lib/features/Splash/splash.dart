import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:madaresco/Util/SharedPrefernce.dart';
import 'package:madaresco/features/Login/data/remote/models/login_model.dart';
import 'package:madaresco/features/Login/presentation/manager/LoginViewModel.dart';
import 'package:madaresco/features/Login/presentation/pages/login_page.dart';
import 'package:madaresco/features/OpeningScreen/OpeningScreen.dart';
import 'package:madaresco/features/Register/presentation/pages/succesful_registration.dart';
import 'package:madaresco/features/SlidePages/slide_pages.dart';
import 'package:madaresco/features/SupervisorOpeningScreen/supervisor_opening_screen.dart';
import 'package:madaresco/features/TeacherOpeningScreen/teacher_opening_screen.dart';
import 'package:madaresco/injection_container.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final Logger _logger = Logger('SPLASH');

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    await Future.delayed(Duration(milliseconds: 500));
    await openScreen(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Image.asset(
          'assets/images/splashLogo.png',
          fit: BoxFit.fill,
          width: 300,
          height: 300,
        ),
      ),
    );
  }

  openScreen(BuildContext context) async {
    bool? isFirstTime;
    LoginModel? model;
    try {
      isFirstTime = await SharedPreference.getIsFirstTime();
    } catch (e) {
      isFirstTime = true;
    }
    try {
      model = await SharedPreference.getLoginModel();
    } catch (e) {
      model = null;
    }
    _logger.info('FirstTime:$isFirstTime');
    if (isFirstTime == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => SlidePages()),
      );
    } else {
      if (model != null) {
        if (model.data!.isActive!) {
          if (model.type == 'teacher') {
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
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) =>
                    SuccesfulRegistration(message: 'student_message')),
          );
        }
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
              create: (_) => sl<LoginViewModel>(),
              child: LoginPage(),
            ),
          ),
        );
      }
    }
  }
}
