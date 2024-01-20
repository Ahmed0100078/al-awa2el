import "dart:developer";
import 'dart:io';
import "package:firebase_core/firebase_core.dart";
import "package:firebase_messaging/firebase_messaging.dart";
import 'package:flutter/material.dart';
import "package:flutter_local_notifications/flutter_local_notifications.dart";
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../features/Absence/presentation/manager/absence_view_model.dart';
import '../features/Absence/presentation/pages/absence_page.dart';
import '../features/Annual/presentation/manager/annuals_view_model.dart';
import '../features/Annual/presentation/pages/annuals_page.dart';
import '../features/ChatWithPerson/presentation/manager/chat_view_model.dart';
import '../features/ChatWithPerson/presentation/pages/new_chat_page.dart';
import '../features/ExamResult/presentation/manager/exam_results_view_model.dart';
import '../features/ExamResult/presentation/pages/exam_results_page.dart';
import '../features/ExamSubjects/presentation/manager/exam_subjects_view_model.dart';
import '../features/ExamSubjects/presentation/pages/exam_subjects_page.dart';
import '../features/LessonDetails/presentation/manager/lesson_details_view_model.dart';
import '../features/LessonDetails/presentation/pages/lesson_details_page.dart';
import '../features/ManagerWord/presentation/manager/manager_word_view_model.dart';
import '../features/ManagerWord/presentation/pages/manager_word_page.dart';
import '../features/Notifications/presentation/manager/notifications_view_model.dart';
import '../features/Notifications/presentation/pages/notifications_page.dart';
import '../features/Schedule/presentation/manager/schedule_view_model.dart';
import '../features/Schedule/presentation/pages/schedule_view.dart';
import '../features/SchoolNews/presentation/manager/school_news_view_model.dart';
import '../features/SchoolNews/presentation/pages/school_news_page.dart';
import '../features/StudentBehavior/presentation/manager/student_behavior_view_model.dart';
import '../features/StudentBehavior/presentation/pages/student_behavior_page.dart';
import '../injection_container.dart';
import '../main.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

/// TODO: Do Something when receive a background Notification.
Future<void> backgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void requestPermissions() {
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestPermission();
}

void showNotification(RemoteMessage event, String payload) async {
  var iOSPlatformChannelSpecifics = const IOSNotificationDetails(
      presentAlert: true, presentBadge: true, presentSound: true);
  var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      "com.elnooronline.alawael", "مدرسة الأوائل الأهلية",
      channelDescription: "مدرسة الأوائل الأهلية",
      enableVibration: true,
      playSound: true,
      icon: "notificationlogo",
      importance: Importance.high,
      priority: Priority.high);
  var notificationDetails = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics);
  String title = "${event.notification!.title}";
  String body = "${event.notification!.body}";
  await flutterLocalNotificationsPlugin
      .show(200, title, body, notificationDetails, payload: payload);
}

void initLocalNotification() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings("notificationlogo");

  const IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
  );

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String? payload) =>
          handleNotificationsTap(payload));
}

Future<void> registerNotification() async {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  await firebaseMessaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
}

handleNotificationsTap(String? payload) async {
  log("Notification click details  $payload");
  if (payload!.isEmpty || payload == '{}') {
    mainNavigatorKey.currentState!.push(MaterialPageRoute(
      builder: (_) => ChangeNotifierProvider(
        create: (_) => sl<NotificationsViewModel>(),
        child: NotificationsPage(),
      ),
    ));
  } else {
    List<String> str =
        payload.replaceAll("{", "").replaceAll("}", "").split(",");
    Map<String, dynamic> data = {};
    for (int i = 0; i < str.length; i++) {
      List<String> s = str[i].split(":");
      data.putIfAbsent(s[0].trim(), () => s[1].trim());
    }
    String modelType = data['view'] ?? "";
    if (modelType == "student" ||
        modelType == "teacher" ||
        modelType == "custom") {
      if (payload.contains("outside_link")) {
        String externalLink = str[1].replaceAll(" outside_link: ", "");
        if (externalLink != "") {
          if (Platform.isAndroid) {
            await launchUrl(Uri.parse(externalLink));
          } else {
            final bool nativeAppLaunchSucceeded = await launchUrl(
              Uri.parse(externalLink),
              mode: LaunchMode.externalNonBrowserApplication,
            );
            if (!nativeAppLaunchSucceeded) {
              await launchUrl(
                Uri.parse(externalLink),
                mode: LaunchMode.inAppWebView,
              );
            }
          }
        }
      }
    } else if (modelType == "attendance") {
      mainNavigatorKey.currentState!.push(
        MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => sl<AbsenceViewModel>(),
            child: AbsencePage(),
          ),
        ),
      );
    } else if (modelType == "admin_word") {
      mainNavigatorKey.currentState!.push(
        MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
              create: (_) => sl<ManagerWordViewModel>(),
              child: ManagerWordPage()),
        ),
      );
    } else if (modelType == "conversation") {
      mainNavigatorKey.currentState!.push(
        MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => sl<ChatViewModel>(),
            child: NewChatPage(
                url: "users/${data['id']}",
                name: data['title'] ?? "",
                isLive: true),
          ),
        ),
      );
    } else if (modelType == "adminstration") {
      mainNavigatorKey.currentState!.push(
        MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => sl<ChatViewModel>(),
            child: NewChatPage(
                url: "adminstration-room",
                name: data['title'] ?? "",
                isLive: true),
          ),
        ),
      );
    } else if (modelType == "exams") {
      mainNavigatorKey.currentState!.push(
        MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => sl<ExamSubjectsViewModel>(),
            child: ExamSubjectsPage(),
          ),
        ),
      );
    } else if (modelType == "installments") {
      mainNavigatorKey.currentState!.push(
        MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => sl<AnnualsViewModel>(),
            child: AnnualsPage(),
          ),
        ),
      );
    } else if (modelType == "lessons") {
      mainNavigatorKey.currentState!.push(
        MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => sl<LessonDetailsViewModel>(),
            child: NewLessonDetailsPage(lessonID: int.parse("${data['id']}")),
          ),
        ),
      );
    } else if (modelType == "news") {
      mainNavigatorKey.currentState!.push(
        MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => sl<SchoolNewsViewModel>(),
            child: SchoolNewsPage(),
          ),
        ),
      );
    } else if (modelType == "results") {
      mainNavigatorKey.currentState!.push(
        MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => sl<ExamResultsViewModel>(),
            child: ExamResultsPage(),
          ),
        ),
      );
    } else if (modelType == "schedules") {
      mainNavigatorKey.currentState!.push(
        MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => sl<ScheduleViewModel>(),
            child: ScheduleView(),
          ),
        ),
      );
    } else if (modelType == "warnings") {
      mainNavigatorKey.currentState!.push(MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider(
          create: (_) => sl<StudentBehaviorViewModel>(),
          child: StudentBehaviorPage(),
        ),
      ));
    } else {
      mainNavigatorKey.currentState!.push(MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider(
          create: (_) => sl<NotificationsViewModel>(),
          child: NotificationsPage(),
        ),
      ));
    }
  }
}

void setupNotifications() {
  registerNotification();
  initLocalNotification();
  requestPermissions();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  FirebaseMessaging.onMessage.listen((RemoteMessage event) {
    if (event.data != {}) {
      showNotification(event, "${event.data}");
    } else {
      showNotification(event, "${event.notification}");
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage event) {
    handleNotificationsTap(event.data.toString());
  });
  log("Notifications init complete");
}
