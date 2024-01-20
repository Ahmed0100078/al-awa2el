import 'package:flutter/material.dart';
import 'package:madaresco/core/constant.dart';
import 'package:madaresco/core/language/app_loclaizations.dart';
import 'package:madaresco/features/ChatWithPerson/presentation/manager/chat_view_model.dart';
import 'package:madaresco/features/MainTeacher/presentation/manager/main_teacher_view_model.dart';
import 'package:madaresco/features/MainTeacher/presentation/pages/main_teacher_page.dart';
import 'package:madaresco/features/SchoolNews/presentation/manager/school_news_view_model.dart';
import 'package:madaresco/features/SchoolNews/presentation/pages/school_news_page.dart';
import 'package:madaresco/features/TeacherOpeningScreen/close_dialog.dart';
import 'package:madaresco/features/TeacherRooms/presentation/manager/teachers_rooms_view_model.dart';
import 'package:madaresco/features/TeacherRooms/presentation/pages/teacher_rooms_page.dart';
import 'package:madaresco/features/TeacherSideMenu/teacher_side_menu.dart';
import 'package:madaresco/main.dart';
import 'package:provider/provider.dart';
import '../../injection_container.dart';
import '../ChatWithPerson/presentation/pages/new_chat_page.dart';

class TeacherOpeningScreen extends StatefulWidget {
  @override
  _TeacherOpeningScreenState createState() => _TeacherOpeningScreenState();
}

final GlobalKey<ScaffoldState> teacherScaffoldKey =
    new GlobalKey<ScaffoldState>();

class _TeacherOpeningScreenState extends State<TeacherOpeningScreen>
    with SingleTickerProviderStateMixin {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    final _items = [
      ChangeNotifierProvider(
          create: (_) => sl<MainTeacherViewModel>(), child: MainTeacherPage()),
      ChangeNotifierProvider(
        create: (_) => sl<ChatViewModel>(),
        child: NewChatPage(url: 'adminstration-room', name: ""),
      ),
      ChangeNotifierProvider(
          create: (_) => sl<TeacherRoomViewModel>(), child: TeacherRoomsPage()),
      ChangeNotifierProvider(
        create: (_) => sl<SchoolNewsViewModel>(),
        child: SchoolNewsPage(withBack: false),
      ),
    ];
    return WillPopScope(
      onWillPop: () async {
        bool lastPage = await mainNavigatorKey.currentState!.maybePop();
        if (!lastPage) {
          bool result = await showCloseDialog(context);
          return result;
        } else {
          return false;
        }
      },
      child: Scaffold(
        key: teacherScaffoldKey,
        drawer: TeacherSideMenu(),
        body: _items[index],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) async {
            setState(() {});
            this.index = index;
          },
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/stayhome.png',
                height: 19,
                width: 19,
                color: index == 0 ? kAccentColor : Colors.black,
              ),
              label: local.translate('home'),
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/technical.png',
                width: 19,
                height: 19,
                color: index == 1 ? kAccentColor : Colors.black,
              ),
              label: local.translate('contact_managment'),
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/support.png',
                width: 20,
                height: 20,
                color: index == 2 ? kAccentColor : Colors.black,
              ),
              label: local.translate('contact_students'),
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/newspaper.png',
                width: 20,
                height: 20,
                color: index == 3 ? kAccentColor : Colors.black,
              ),
              label: local.translate('school_news'),
            ),
          ],
          showUnselectedLabels: true,
          unselectedItemColor: Colors.black,
          selectedItemColor: kAccentColor,
          currentIndex: index,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }

  void setIndex(int index) {
    this.index = index;
    mainNavigatorKey.currentState!.maybePop();
    setState(() {});
  }

  Future<dynamic> showCloseDialog(BuildContext context) async {
    Dialog alertDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
      child: CloseDialog(),
    );
    var close = await showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return ScaleTransition(scale: a1, child: alertDialog);
        },
        transitionDuration: Duration(milliseconds: 250),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        // ignore: missing_return
        pageBuilder: (context, animation1, animation2) {
          return SizedBox();
        });
    return close;
  }
}
