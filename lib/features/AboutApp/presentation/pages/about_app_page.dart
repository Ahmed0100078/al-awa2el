import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madaresco/core/constant.dart';
import 'package:madaresco/core/language/app_loclaizations.dart';
import 'package:madaresco/features/AboutApp/presentation/manager/about_app_view_model.dart';
import 'package:madaresco/features/Login/presentation/manager/LoginViewModel.dart';
import 'package:madaresco/features/OpeningScreen/OpeningScreen.dart';
import 'package:madaresco/features/TeacherOpeningScreen/teacher_opening_screen.dart';
import 'package:madaresco/main.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class AboutAppPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    AboutAppViewModel vm = Provider.of<AboutAppViewModel>(context);
    vm.toast.addListener(() {
      if (vm.toast.value.getContentIfNotHandled() != null) {
        if (vm.toast.value.peekContent() == SERVER_FAILURE_MESSAGE) {
          Fluttertoast.showToast(msg: SERVER_FAILURE_MESSAGE);
        } else {
          Fluttertoast.showToast(
              msg: local.translate(vm.toast.value.peekContent()));
        }
      }
    });
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: vm.loading,
        builder: (context, bool loading, child) {
          return ModalProgressHUD(inAsyncCall: loading, child: child!);
        },
        child: Stack(
          clipBehavior: Clip.none,
          fit: StackFit.expand,
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: 200,
                child: Material(
                  elevation: 4,
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16.0),
                      bottomRight: Radius.circular(16.0)),
                  child: AppBar(
                    flexibleSpace: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        colors: [
                          Color(0xFF001068),
                          Color(0xFF001068),
                        ],
                      )),
                    ),
                    actions: [
                      GestureDetector(
                        onTap: () {
                          try {
                            mainNavigatorKey.currentState!.pop();
                          } catch (e) {
                            mainNavigatorKey.currentState!.pop();
                          }
                        },
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14.0),
                            child: Icon(Icons.arrow_forward_ios)),
                      ),
                    ],
                    leading: GestureDetector(
                      onTap: () {
                        try {
                          scaffoldKey.currentState!.openDrawer();
                        } catch (e) {
                          teacherScaffoldKey.currentState!.openDrawer();
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14.0),
                        child: Image.asset(
                          'assets/images/menu.png',
                          width: 30,
                          height: 30,
                        ),
                      ),
                    ),
                    centerTitle: true,
                    title: Text(
                      local.translate('about_app'),
                      style: GoogleFonts.cairo(
                          fontSize: 16.0, fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 140,
              bottom: 0,
              right: 10,
              left: 10,
              child: Material(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                )),
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(
                          height: 30.0,
                        ),
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: kAccentColor,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 26.0),
                            child: Text(local.translate(vm.entity.name),
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            local.translate('about_app'),
                            style: TextStyle(
                                color: kAccentColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Container(
                            padding: EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                                border: Border.all(color: Colors.grey)),
                            child: Html(
                              data: vm.entity.about,
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
