import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madaresco/core/language/app_loclaizations.dart';
import 'package:madaresco/features/Login/presentation/manager/LoginViewModel.dart';
import 'package:madaresco/features/Notifications/presentation/manager/notifications_view_model.dart';
import 'package:madaresco/features/Notifications/presentation/widgets/notification_row.dart';
import 'package:madaresco/features/OpeningScreen/OpeningScreen.dart';
import 'package:madaresco/features/TeacherOpeningScreen/teacher_opening_screen.dart';
import 'package:madaresco/main.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    NotificationsViewModel vm = Provider.of<NotificationsViewModel>(context);
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
                        ),
                      ),
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
                    leading: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.0),
                      child: GestureDetector(
                        onTap: () {
                          try {
                            teacherScaffoldKey.currentState!.openDrawer();
                          } catch (e) {
                            scaffoldKey.currentState!.openDrawer();
                          }
                        },
                        child: Image.asset(
                          'assets/images/menu.png',
                          width: 30,
                          height: 30,
                        ),
                      ),
                    ),
                    centerTitle: true,
                    title: Text(
                      local.translate('notifications'),
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
                    borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20.0),
                  // topRight: Radius.circular(20.0),
                )),
                child: ListView(
                  children: vm.entity.notifications
                      .map((e) => NotificationsRow(notification: e))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
