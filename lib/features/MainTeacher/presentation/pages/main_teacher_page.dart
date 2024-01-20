import 'package:badges/badges.dart' as badges;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madaresco/Util/app_lifecycle_handler.dart';
import 'package:madaresco/core/constant.dart';
import 'package:madaresco/core/language/app_loclaizations.dart';
import 'package:madaresco/features/AddOnlineLesson/presentation/manager/add_online_lesson_view_model.dart';
import 'package:madaresco/features/AddOnlineLesson/presentation/pages/add_online_lesson_page.dart';
import 'package:madaresco/features/Login/presentation/manager/LoginViewModel.dart';
import 'package:madaresco/features/MainTeacher/presentation/manager/main_teacher_view_model.dart';
import 'package:madaresco/features/Notifications/presentation/manager/notifications_view_model.dart';
import 'package:madaresco/features/Notifications/presentation/pages/notifications_page.dart';
import 'package:madaresco/features/OnlineLessons/presentation/manager/online_lessons_view_model.dart';
import 'package:madaresco/features/OnlineLessons/presentation/pages/online_lessons_page.dart';
import 'package:madaresco/features/Schedule/presentation/manager/schedule_view_model.dart';
import 'package:madaresco/features/Schedule/presentation/pages/schedule_view.dart';
import 'package:madaresco/features/TeacherOpeningScreen/teacher_opening_screen.dart';
import 'package:madaresco/features/UploadLesson/presentation/manager/upload_lesson_view_model.dart';
import 'package:madaresco/features/UploadLesson/presentation/pages/upload_lesson_page.dart';
import 'package:madaresco/injection_container.dart';
import 'package:madaresco/main.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '../../../../core/Network/network.dart';
import '../../../../core/notification_handler.dart';
import '../../../Subjects/presentation/manager/subject_viewmodel.dart';
import '../../../Subjects/presentation/pages/subjects_page.dart';

class MainTeacherPage extends StatefulWidget {
  @override
  _MainTeacherPageState createState() => _MainTeacherPageState();
}

class _MainTeacherPageState extends State<MainTeacherPage> {
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance
    //     .addObserver(LifecycleEventHandler(resumeCallBack: () async {
    //   MainTeacherViewModel vm =
    //       Provider.of<MainTeacherViewModel>(context, listen: false);
    //   vm.getNotifications();
    //   print('Catched on Resume');
    // }));
    Network().updateFcmToken(context);
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        if (message.data != {}) {
          handleNotificationsTap(
            message.data.toString(),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    MainTeacherViewModel vm = Provider.of<MainTeacherViewModel>(context);
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
    getNotifications.addListener(() {
      if (getNotifications.value.getContentIfNotHandled() != null) {
        if (getNotifications.value.peekContent()) {
          vm.getNotifications();
        }
      }
    });
    return AppLifeCycleHandler(
      resumeCallBack: () async {
        // MainTeacherViewModel vm =
        //     Provider.of<MainTeacherViewModel>(context, listen: false);
        vm.getNotifications();
        print('Catched on Resume');
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(300),
          child: Stack(clipBehavior: Clip.none, children: <Widget>[
            SizedBox(
              height: 190,
              child: Material(
                elevation: 4,
                clipBehavior: Clip.hardEdge,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(34.0),
                    bottomRight: Radius.circular(34.0)),
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
                  leading: InkWell(
                    onTap: () {
                      teacherScaffoldKey.currentState!.openDrawer();
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
                  actions: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: IconButton(
                          icon: badges.Badge(
                            position: badges.BadgePosition.topStart(),
                            badgeAnimation: badges.BadgeAnimation.scale(),
                            badgeContent: Text(
                              "${vm.notificationCounter}",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            child:
                                Image.asset('assets/images/notification.png'),
                          ),
                          onPressed: () {
                            mainNavigatorKey.currentState!.push(
                              MaterialPageRoute(
                                builder: (_) => ChangeNotifierProvider(
                                  create: (_) => sl<NotificationsViewModel>(),
                                  child: NotificationsPage(),
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                  centerTitle: true,
                  title: Text(
                    local.translate('main'),
                    style: GoogleFonts.cairo(
                        fontSize: 16.0, fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -60,
              top: 100,
              right: 16,
              left: 16,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(34.0)),
                elevation: 6,
                child: Stack(
                  fit: StackFit.expand,
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    Positioned(
                      top: -25,
                      right: 16,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.all(1.5),
                        child: CircleAvatar(
                          radius: 40.0,
                          backgroundColor: Colors.white,
                          backgroundImage: vm.entity.avatar.isEmpty
                              ? AssetImage('assets/images/user2.png')
                                  as ImageProvider
                              : NetworkImage(vm.entity.avatar),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 19.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              width: 20.0,
                            ),
                            Text(
                              local.translate('welcome'),
                              style: TextStyle(
                                  color: kAccentColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              vm.entity.name,
                              style: TextStyle(color: Colors.black),
                            )
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 19.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      tileMode: TileMode.repeated,
                                      colors: [
                                        Color(0xFF001068),
                                        Color(0xFF001068),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(26.0)),
                                child: Text(
                                  vm.entity.school,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                                padding: EdgeInsets.all(10.0),
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    tileMode: TileMode.repeated,
                                    colors: [
                                      Color(0xFF001068),
                                      Color(0xFF001068),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(26.0)),
                              child: Text(
                                vm.entity.subject,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                              padding: EdgeInsets.all(10.0),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ]),
        ),
        body: ValueListenableBuilder(
          valueListenable: vm.loading,
          builder: (context, bool loading, child) {
            return ModalProgressHUD(inAsyncCall: loading, child: child!);
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 70,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            'assets/images/add.png',
                            height: 60,
                          ),
                          SizedBox(
                            width: 16.0,
                          ),
                          Expanded(
                              child: GestureDetector(
                            onTap: () {
                              mainNavigatorKey.currentState!.push(
                                MaterialPageRoute(
                                  builder: (_) => ChangeNotifierProvider(
                                    create: (_) => sl<UploadLessonViewModel>(),
                                    child: UploadLessonPage(),
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Text(
                                  local.translate('add_lesson'),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: kAccentColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 2.0,
                                ),
                                Text(
                                  local.translate('add_lesson_desc'),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ))
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    mainNavigatorKey.currentState!.push(
                      MaterialPageRoute(
                        builder: (_) => ChangeNotifierProvider(
                          create: (_) => sl<AddOnlineLessonViewModel>(),
                          child: AddOnlineLessonPage(),
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              'assets/images/add2.png',
                              height: 60,
                            ),
                            SizedBox(
                              width: 16.0,
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Text(
                                  local.translate('add_online_lesson'),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: kAccentColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 2.0,
                                ),
                                Text(
                                  local.translate('add_online_lesson_desc'),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    mainNavigatorKey.currentState!.push(
                      MaterialPageRoute(
                        builder: (_) => ChangeNotifierProvider(
                          create: (_) => sl<OnlineLessonsViewModel>(),
                          child: OnlineLessonsPage(
                            isTeacher: true,
                          ),
                        ),
                      ),
                    );
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              'assets/images/technical.png',
                              height: 60,
                            ),
                            SizedBox(
                              width: 16.0,
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Text(
                                  local.translate('online_lessons'),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: kAccentColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 2.0,
                                ),
                                Text(
                                  local.translate('online_desc'),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    mainNavigatorKey.currentState!.push(
                      MaterialPageRoute(
                        builder: (_) => ChangeNotifierProvider(
                          create: (_) => sl<ScheduleViewModel>(),
                          child: ScheduleView(),
                        ),
                      ),
                    );
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              'assets/images/calendar.png',
                              height: 60,
                            ),
                            SizedBox(
                              width: 16.0,
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Text(
                                  local.translate('schedule'),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: kAccentColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 2.0,
                                ),
                                Text(
                                  local.translate('schedule_desc'),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    mainNavigatorKey.currentState!.push(
                      MaterialPageRoute(
                        builder: (_) => ChangeNotifierProvider(
                            create: (_) => sl<SubjectViewModel>(),
                            child: SubjectsPage(
                              isTeacher: true,
                            )),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              'assets/images/notebook.png',
                              height: 60,
                            ),
                            SizedBox(
                              width: 16.0,
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Text(
                                  local.translate('daily_homework'),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: kAccentColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 2.0,
                                ),
                                Text(
                                  local.translate('daily_homework_desc'),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
