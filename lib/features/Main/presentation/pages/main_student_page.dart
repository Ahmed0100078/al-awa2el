import 'package:badges/badges.dart' as badges;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madaresco/Util/app_lifecycle_handler.dart';
import 'package:madaresco/core/constant.dart';
import 'package:madaresco/core/language/app_loclaizations.dart';
import 'package:madaresco/features/Absence/presentation/manager/absence_view_model.dart';
import 'package:madaresco/features/Absence/presentation/pages/absence_page.dart';
import 'package:madaresco/features/Annual/presentation/manager/annuals_view_model.dart';
import 'package:madaresco/features/Annual/presentation/pages/annuals_page.dart';
import 'package:madaresco/features/Curricula/presentation/manager/curricula_view_model.dart';
import 'package:madaresco/features/Curricula/presentation/pages/curricula_page.dart';
import 'package:madaresco/features/ExamResult/presentation/manager/exam_results_view_model.dart';
import 'package:madaresco/features/ExamResult/presentation/pages/exam_results_page.dart';
import 'package:madaresco/features/ExamSubjects/presentation/manager/exam_subjects_view_model.dart';
import 'package:madaresco/features/ExamSubjects/presentation/pages/exam_subjects_page.dart';
import 'package:madaresco/features/Gallary/presentation/manager/gallary_view_model.dart';
import 'package:madaresco/features/Gallary/presentation/pages/gallarys_page.dart';
import 'package:madaresco/features/Login/presentation/manager/LoginViewModel.dart';
import 'package:madaresco/features/MadarescoLessons/presentation/manager/madaresco_view_model.dart';
import 'package:madaresco/features/MadarescoLessons/presentation/pages/madaresco_lessons_page.dart';
import 'package:madaresco/features/Main/domain/entities/NotEntity.dart';
import 'package:madaresco/features/Main/presentation/manager/MainViewModel.dart';
import 'package:madaresco/features/Main/presentation/widgets/MainRow.dart';
import 'package:madaresco/features/ManagerWord/presentation/manager/manager_word_view_model.dart';
import 'package:madaresco/features/ManagerWord/presentation/pages/manager_word_page.dart';
import 'package:madaresco/features/Notifications/presentation/manager/notifications_view_model.dart';
import 'package:madaresco/features/Notifications/presentation/pages/notifications_page.dart';
import 'package:madaresco/features/OnlineLessons/presentation/manager/online_lessons_view_model.dart';
import 'package:madaresco/features/OnlineLessons/presentation/pages/online_lessons_page.dart';
import 'package:madaresco/features/OpeningScreen/OpeningScreen.dart';
import 'package:madaresco/features/Schedule/presentation/manager/schedule_view_model.dart';
import 'package:madaresco/features/Schedule/presentation/pages/schedule_view.dart';
import 'package:madaresco/features/SchoolNews/presentation/manager/school_news_view_model.dart';
import 'package:madaresco/features/SchoolNews/presentation/pages/school_news_page.dart';
import 'package:madaresco/features/StudentBehavior/presentation/manager/student_behavior_view_model.dart';
import 'package:madaresco/features/StudentBehavior/presentation/pages/student_behavior_page.dart';
import 'package:madaresco/features/Subjects/presentation/manager/subject_viewmodel.dart';
import 'package:madaresco/features/Subjects/presentation/pages/subjects_page.dart';
import 'package:madaresco/main.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '../../../../core/Network/network.dart';
import '../../../../core/notification_handler.dart';
import '../../../../injection_container.dart';

class MainStudentPage extends StatefulWidget {
  @override
  _MainStudentPageState createState() => _MainStudentPageState();
}

class _MainStudentPageState extends State<MainStudentPage> {
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance
    //     .addObserver(LifecycleEventHandler(resumeCallBack: () async {
    //   MainViewModel vm = Provider.of<MainViewModel>(
    //     context,
    //     // listen: false
    //   );
    //   vm.getData();
    //   vm.getNotifications();
    //   print('Caught on Resume');
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
    MainViewModel vm = Provider.of<MainViewModel>(context);
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
    return ValueListenableBuilder<NotEntity>(
      valueListenable: notEntity,
      builder: (context, notEntity, child) {
        return AppLifeCycleHandler(
          resumeCallBack: () async {
            // MainViewModel vm = Provider.of<MainViewModel>(
            //   context,
            //   // listen: false
            // );
            vm.getData();
            vm.getNotifications();
            print('Caught on Resume');
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
                          scaffoldKey.currentState!.openDrawer();
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
                                  "${vm.notificationsCount}",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white),
                                ),
                                child: Image.asset(
                                    'assets/images/notification.png'),
                              ),
                              onPressed: () {
                                mainNavigatorKey.currentState!
                                    .push(MaterialPageRoute(
                                  builder: (_) => ChangeNotifierProvider(
                                    create: (_) => sl<NotificationsViewModel>(),
                                    child: NotificationsPage(),
                                  ),
                                ));
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
                            child: Column(
                              children: [
                                Row(
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
                                SizedBox(
                                  height: 2.0,
                                ),
                                Text(
                                  vm.entity.grade,
                                  style: TextStyle(
                                      color: kAccentColor,
                                      fontWeight: FontWeight.bold),
                                ),
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
                                        borderRadius:
                                            BorderRadius.circular(26.0)),
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
                                      borderRadius:
                                          BorderRadius.circular(26.0)),
                                  child: Text(
                                    vm.entity.stage + '-' + vm.entity.section,
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
                      height: 65,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                mainNavigatorKey.currentState!.push(
                                  MaterialPageRoute(
                                    builder: (_) => ChangeNotifierProvider(
                                        create: (_) => sl<SubjectViewModel>(),
                                        child: SubjectsPage()),
                                  ),
                                );
                              },
                              child: MainRow(
                                local: local,
                                image: 'assets/images/notebook.png',
                                text: 'daily_homework',
                                notificationCount: notEntity.lessonsCount,
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                mainNavigatorKey.currentState!.push(
                                  MaterialPageRoute(
                                    builder: (_) => ChangeNotifierProvider(
                                      create: (_) =>
                                          sl<OnlineLessonsViewModel>(),
                                      child: OnlineLessonsPage(),
                                    ),
                                  ),
                                );
                              },
                              behavior: HitTestBehavior.translucent,
                              child: MainRow(
                                local: local,
                                image: 'assets/images/technical.png',
                                text: 'online_lessons',
                                notificationCount: notEntity.onlineLessonCount,
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                mainNavigatorKey.currentState!.push(
                                  MaterialPageRoute(
                                    builder: (_) => ChangeNotifierProvider(
                                      create: (_) =>
                                          sl<StudentBehaviorViewModel>(),
                                      child: StudentBehaviorPage(),
                                    ),
                                  ),
                                );
                              },
                              child: MainRow(
                                local: local,
                                image: 'assets/images/student.png',
                                text: 'behavior',
                                notificationCount: notEntity.warningCount,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        mainNavigatorKey.currentState!.push(
                          MaterialPageRoute(
                            builder: (_) => ChangeNotifierProvider(
                              create: (_) => sl<MadarescoLessonsViewModel>(),
                              child: MadarescoLessonsPage(),
                            ),
                          ),
                        );
                      },
                      behavior: HitTestBehavior.translucent,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Card(
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
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
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 16.0,
                                ),
                                Expanded(
                                  child: Text(
                                    local.translate('lessons_from_schools'),
                                    textAlign: TextAlign.start,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Image.asset(
                                  'assets/images/school2.png',
                                  height: 40,
                                ),
                                SizedBox(
                                  width: 10.0,
                                )
                              ],
                            ),
                            padding: EdgeInsets.all(16.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                mainNavigatorKey.currentState!.push(
                                  MaterialPageRoute(
                                    builder: (_) => ChangeNotifierProvider(
                                        create: (_) => sl<AbsenceViewModel>(),
                                        child: AbsencePage()),
                                  ),
                                );
                              },
                              behavior: HitTestBehavior.translucent,
                              child: MainRow(
                                local: local,
                                image: 'assets/images/clipboard.png',
                                text: 'absence',
                                notificationCount: notEntity.attendanceCount,
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                mainNavigatorKey.currentState!.push(
                                  MaterialPageRoute(
                                    builder: (_) => ChangeNotifierProvider(
                                        create: (_) => sl<AnnualsViewModel>(),
                                        child: AnnualsPage()),
                                  ),
                                );
                              },
                              behavior: HitTestBehavior.translucent,
                              child: MainRow(
                                local: local,
                                image: 'assets/images/money.png',
                                text: 'installments',
                                notificationCount: notEntity.installmentCount,
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                mainNavigatorKey.currentState!.push(
                                  MaterialPageRoute(
                                    builder: (_) => ChangeNotifierProvider(
                                        create: (_) =>
                                            sl<ExamSubjectsViewModel>(),
                                        child: ExamSubjectsPage()),
                                  ),
                                );
                              },
                              behavior: HitTestBehavior.translucent,
                              child: MainRow(
                                local: local,
                                image: 'assets/images/calendar2.png',
                                text: 'exams_time_table',
                                notificationCount: notEntity.examsCount,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                if (vm.entity.appearResults == 1) {
                                  mainNavigatorKey.currentState!.push(
                                    MaterialPageRoute(
                                      builder: (_) => ChangeNotifierProvider(
                                          create: (_) =>
                                              sl<ExamResultsViewModel>(),
                                          child: ExamResultsPage()),
                                    ),
                                  );
                                } else {
                                  Fluttertoast.showToast(
                                      msg: local
                                          .translate("result_not_approved"));
                                }
                              },
                              behavior: HitTestBehavior.translucent,
                              child: MainRow(
                                local: local,
                                image: 'assets/images/page.png',
                                text: 'exams_result',
                                notificationCount: notEntity.resultCount,
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
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
                              child: MainRow(
                                local: local,
                                image: 'assets/images/calendar.png',
                                text: 'time_table',
                                notificationCount: notEntity.schedulesCount,
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                mainNavigatorKey.currentState!.push(
                                  MaterialPageRoute(
                                    builder: (_) => ChangeNotifierProvider(
                                      create: (_) => sl<SchoolNewsViewModel>(),
                                      child: SchoolNewsPage(),
                                    ),
                                  ),
                                );
                              },
                              child: MainRow(
                                local: local,
                                image: 'assets/images/newspaper.png',
                                text: 'school_news',
                                notificationCount: notEntity.newsCount,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        mainNavigatorKey.currentState!.push(
                          MaterialPageRoute(
                            builder: (_) => ChangeNotifierProvider(
                              create: (_) => sl<CurriculaViewModel>(),
                              child: CurriculaPage(),
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Card(
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
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
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 16.0,
                                ),
                                Expanded(
                                  child: Text(
                                    local.translate('curriculum'),
                                    textAlign: TextAlign.start,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Image.asset(
                                  'assets/images/book.png',
                                  height: 40,
                                ),
                                SizedBox(
                                  width: 10.0,
                                )
                              ],
                            ),
                            padding: EdgeInsets.all(16.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                mainNavigatorKey.currentState!.push(
                                  MaterialPageRoute(
                                    builder: (_) => ChangeNotifierProvider(
                                        create: (_) =>
                                            sl<ManagerWordViewModel>(),
                                        child: ManagerWordPage()),
                                  ),
                                );
                              },
                              behavior: HitTestBehavior.translucent,
                              child: MainRow(
                                local: local,
                                image: 'assets/images/man.png',
                                text: 'manger_word',
                                notificationCount: notEntity.adminWordCount,
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                mainNavigatorKey.currentState!.push(
                                  MaterialPageRoute(
                                    builder: (_) => ChangeNotifierProvider(
                                      create: (_) => sl<GallaryViewModel>(),
                                      child: GallarysPage(),
                                    ),
                                  ),
                                );
                              },
                              behavior: HitTestBehavior.translucent,
                              child: MainRow(
                                local: local,
                                image: 'assets/images/photo.png',
                                text: 'gallary',
                                notificationCount: notEntity.schoolMediaCount,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
