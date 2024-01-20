import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:madaresco/core/constant.dart';
import 'package:madaresco/features/Notifications/domain/entities/notification_entity.dart';
import 'package:madaresco/features/Schedule/presentation/pages/schedule_view.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../injection_container.dart';
import '../../../../main.dart';
import '../../../Absence/presentation/manager/absence_view_model.dart';
import '../../../Absence/presentation/pages/absence_page.dart';
import '../../../Annual/presentation/manager/annuals_view_model.dart';
import '../../../Annual/presentation/pages/annuals_page.dart';
import '../../../ChatWithPerson/presentation/manager/chat_view_model.dart';
import '../../../ChatWithPerson/presentation/pages/new_chat_page.dart';
import '../../../ExamResult/presentation/manager/exam_results_view_model.dart';
import '../../../ExamResult/presentation/pages/exam_results_page.dart';
import '../../../ExamSubjects/presentation/manager/exam_subjects_view_model.dart';
import '../../../ExamSubjects/presentation/pages/exam_subjects_page.dart';
import '../../../LessonDetails/presentation/manager/lesson_details_view_model.dart';
import '../../../LessonDetails/presentation/pages/lesson_details_page.dart';
import '../../../ManagerWord/presentation/manager/manager_word_view_model.dart';
import '../../../ManagerWord/presentation/pages/manager_word_page.dart';
import '../../../Schedule/presentation/manager/schedule_view_model.dart';
import '../../../SchoolNews/presentation/manager/school_news_view_model.dart';
import '../../../SchoolNews/presentation/pages/school_news_page.dart';
import '../../../StudentBehavior/presentation/manager/student_behavior_view_model.dart';
import '../../../StudentBehavior/presentation/pages/student_behavior_page.dart';

class NotificationsRow extends StatelessWidget {
  final NotificationEntity notification;

  NotificationsRow({
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        log("Notification click details ${notification.view}");
        log("Notification click details  ${notification.dataId}");
        log("Notification click details  ${notification.outSideLink}");
        if (notification.view == "student" ||
            notification.view == "teacher" ||
            notification.view == "custom") {
          if (notification.outSideLink != '' &&
              notification.outSideLink != null) {
            if (Platform.isAndroid) {
              await launchUrl(Uri.parse(notification.outSideLink!));
            } else {
              final bool nativeAppLaunchSucceeded = await launchUrl(
                Uri.parse((notification.outSideLink!)),
                mode: LaunchMode.externalNonBrowserApplication,
              );
              if (!nativeAppLaunchSucceeded) {
                await launchUrl(
                  Uri.parse((notification.outSideLink!)),
                  mode: LaunchMode.inAppWebView,
                );
              }
            }
          }
        } else if (notification.view == "attendance") {
          mainNavigatorKey.currentState!.push(
            MaterialPageRoute(
              builder: (_) => ChangeNotifierProvider(
                create: (_) => sl<AbsenceViewModel>(),
                child: AbsencePage(),
              ),
            ),
          );
        } else if (notification.view == "admin_word") {
          mainNavigatorKey.currentState!.push(
            MaterialPageRoute(
              builder: (_) => ChangeNotifierProvider(
                  create: (_) => sl<ManagerWordViewModel>(),
                  child: ManagerWordPage()),
            ),
          );
        } else if (notification.view == "conversation" &&
            notification.dataId != 0 &&
            notification.dataId != "" &&
            notification.dataId != null) {
          mainNavigatorKey.currentState!.push(
            MaterialPageRoute(
              builder: (_) => ChangeNotifierProvider(
                create: (_) => sl<ChatViewModel>(),
                child: NewChatPage(
                    url: "users/${notification.dataId}",
                    name: notification.author,
                    isLive: true),
              ),
            ),
          );
        } else if (notification.view == "adminstration") {
          mainNavigatorKey.currentState!.push(
            MaterialPageRoute(
              builder: (_) => ChangeNotifierProvider(
                create: (_) => sl<ChatViewModel>(),
                child: NewChatPage(
                    url: "adminstration-room",
                    name: notification.author,
                    isLive: true),
              ),
            ),
          );
        } else if (notification.view == "exams") {
          mainNavigatorKey.currentState!.push(
            MaterialPageRoute(
              builder: (_) => ChangeNotifierProvider(
                create: (_) => sl<ExamSubjectsViewModel>(),
                child: ExamSubjectsPage(),
              ),
            ),
          );
        } else if (notification.view == "installments") {
          mainNavigatorKey.currentState!.push(
            MaterialPageRoute(
              builder: (_) => ChangeNotifierProvider(
                create: (_) => sl<AnnualsViewModel>(),
                child: AnnualsPage(),
              ),
            ),
          );
        } else if (notification.view == "lesson" &&
            notification.dataId != 0 &&
            notification.dataId != "" &&
            notification.dataId != null) {
          mainNavigatorKey.currentState!.push(
            MaterialPageRoute(
              builder: (_) => ChangeNotifierProvider(
                create: (_) => sl<LessonDetailsViewModel>(),
                child: NewLessonDetailsPage(
                    lessonID: int.parse("${notification.dataId}")),
              ),
            ),
          );
        } else if (notification.view == "news") {
          mainNavigatorKey.currentState!.push(
            MaterialPageRoute(
              builder: (_) => ChangeNotifierProvider(
                create: (_) => sl<SchoolNewsViewModel>(),
                child: SchoolNewsPage(),
              ),
            ),
          );
        } else if (notification.view == "results") {
          mainNavigatorKey.currentState!.push(
            MaterialPageRoute(
              builder: (_) => ChangeNotifierProvider(
                create: (_) => sl<ExamResultsViewModel>(),
                child: ExamResultsPage(),
              ),
            ),
          );
        } else if (notification.view == "schedules") {
          mainNavigatorKey.currentState!.push(
            MaterialPageRoute(
              builder: (_) => ChangeNotifierProvider(
                create: (_) => sl<ScheduleViewModel>(),
                child: ScheduleView(),
              ),
            ),
          );
        } else if (notification.view == "warnings") {
          mainNavigatorKey.currentState!.push(MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
              create: (_) => sl<StudentBehaviorViewModel>(),
              child: StudentBehaviorPage(),
            ),
          ));
        } else {
          print('else');
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.network(
                    notification.image,
                    height: 60,
                    width: 60,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        notification.body,
                        style: TextStyle(
                          color: kAccentColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: <Widget>[
                          Flexible(
                            child: Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 5.0,
                                ),
                                Image.asset(
                                  'assets/images/user2.png',
                                  height: 16.0,
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Flexible(
                                  child: Text(
                                    notification.author,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Image.asset(
                                'assets/images/clock2.png',
                                height: 16.0,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                notification.time,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
