// import 'dart:io';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:madaresco/Util/Event.dart';
// import 'package:madaresco/Util/SharedPrefernce.dart';
// import 'package:madaresco/core/constant.dart';
// import 'package:madaresco/features/Absence/presentation/manager/absence_view_model.dart';
// import 'package:madaresco/features/Absence/presentation/pages/absence_page.dart';
// import 'package:madaresco/features/Annual/presentation/manager/annuals_view_model.dart';
// import 'package:madaresco/features/Annual/presentation/pages/annuals_page.dart';
// import 'package:madaresco/features/ChatWithPerson/presentation/manager/chat_view_model.dart';
// import 'package:madaresco/features/ChatWithPerson/presentation/pages/chat_page.dart';
// import 'package:madaresco/features/ExamResult/presentation/manager/exam_results_view_model.dart';
// import 'package:madaresco/features/ExamResult/presentation/pages/exam_results_page.dart';
// import 'package:madaresco/features/ExamSubjects/presentation/manager/exam_subjects_view_model.dart';
// import 'package:madaresco/features/ExamSubjects/presentation/pages/exam_subjects_page.dart';
// import 'package:madaresco/features/Gallary/presentation/manager/gallary_view_model.dart';
// import 'package:madaresco/features/Gallary/presentation/pages/gallarys_page.dart';
// import 'package:madaresco/features/LessonDetails/presentation/manager/lesson_details_view_model.dart';
// import 'package:madaresco/features/LessonDetails/presentation/pages/lesson_details_page.dart';
// import 'package:madaresco/features/Login/data/remote/models/login_model.dart';
// import 'package:madaresco/features/ManagerWord/presentation/manager/manager_word_view_model.dart';
// import 'package:madaresco/features/ManagerWord/presentation/pages/manager_word_page.dart';
// import 'package:madaresco/features/OpeningScreen/OpeningScreen.dart';
// import 'package:madaresco/features/Schedule/presentation/manager/schedule_view_model.dart';
// import 'package:madaresco/features/Schedule/presentation/pages/schedule_view.dart';
// import 'package:madaresco/features/SchoolNews/presentation/manager/school_news_view_model.dart';
// import 'package:madaresco/features/SchoolNews/presentation/pages/school_news_page.dart';
// import 'package:madaresco/features/StudentBehavior/presentation/manager/student_behavior_view_model.dart';
// import 'package:madaresco/features/StudentBehavior/presentation/pages/student_behavior_page.dart';
// import 'package:madaresco/features/TeacherOpeningScreen/teacher_opening_screen.dart';
// import 'package:madaresco/main.dart';
// import 'package:provider/provider.dart';
// import '../injection_container.dart';

// Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
//   print('Notification $message');
//   if (message.containsKey('data')) {
//     // Handle data message
//     final dynamic data = message['data'];
//     print('data $data');

//     FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//         FlutterLocalNotificationsPlugin();
//     var initilaizeAndroid = AndroidInitializationSettings('mipmap/ic_launcher');
//     var initilaizeIos = IOSInitializationSettings();
//     var initilaizationSettings =
//         InitializationSettings( initilaizeAndroid,  initilaizeIos);
//     flutterLocalNotificationsPlugin.initialize(initilaizationSettings);

//     var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
//         '100', 'madaresco', 'Madaresco Notification Channel',
//         importance: Importance.High, priority: Priority.High);
//     var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
//     var platformChannelSpecifics = new NotificationDetails(
//         android: androidPlatformChannelSpecifics,
//         iOS: iOSPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(100, message['data']['title'],
//         message['data']['body'], platformChannelSpecifics,
//         payload: message['data']['title'] + '+' + message['data']['body']);
//   }

//   if (message.containsKey('notification')) {
//     // Handle notification message
//     final dynamic notification = message['notification'];
//     print('notification $notification');
//   }

//   // Or do other work.
// }

// class NotificationHandler {
//   BuildContext context;
//   bool isHandeled = false;
//   String token;
//   static final NotificationHandler _notificationHandler =
//       NotificationHandler._internal();

//   factory NotificationHandler() {
//     return _notificationHandler;
//   }

//   NotificationHandler._internal();

//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

//   init(BuildContext context) {
//     if (this.context != null) isHandeled = true;
//     this.context = context;
//     _firebaseMessaging.requestNotificationPermissions(
//         IosNotificationSettings(badge: true, sound: true, alert: true));
//     _firebaseMessaging.getToken().then((token) {
//       print('token : $token');
//       this.token = token;
//     });
//     flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//     var initilaizeAndroid = AndroidInitializationSettings('mipmap/ic_launcher');
//     var initilaizeIos = IOSInitializationSettings();
//     var initilaizationSettings =
//         InitializationSettings( initilaizeAndroid,initilaizeIos);
//     flutterLocalNotificationsPlugin.initialize(initilaizationSettings,
//         onSelectNotification: (payload) =>
//             onSelectNotifications(payload, this.context));

//     _firebaseMessaging.configure(
//       onMessage: (Map<String, dynamic> message) async {
//         print("onMessage: $message");
//         print('data ${message['data']['id']}');
//         _showNotificationWithDefaultSound(message);
//         if (message['data']['view'] == 'users.activated') {
//           LoginModel model = await SharedPreference.getLoginModel();
//           LoginDatas edited = LoginDatas(
//               about: model.data.about,
//               type: model.data.type,
//               name: model.data.name,
//               isActive: true,
//               warnings: model.data.warnings,
//               avatar: model.data.avatar,
//               email: model.data.email,
//               id: model.data.id,
//               isConnected: model.data.isConnected,
//               mobile: model.data.mobile,
//               school: model.data.school,
//               section: model.data.section);
//           SharedPreference.updateLoginModel(edited);
//           if (model.data.type == 'student') {
//             mainNavigatorKey.currentState.pushReplacement(
//               MaterialPageRoute(builder: (_) => OpeningScreen()),
//             );
//           } else {
//             mainNavigatorKey.currentState.pushReplacement(
//               MaterialPageRoute(builder: (_) => TeacherOpeningScreen()),
//             );
//           }
//         }
//         getNotifications.value = Event(true);
//       },
//       onBackgroundMessage: Platform.isIOS
//           ? myBackgroundMessageHandler
//           : myBackgroundMessageHandler,
//       onLaunch: (Map<String, dynamic> message) async {
//         print("onLaunch: $message");
//         Platform.isAndroid
//             ? _openNotification(message['data']['view'],
//                 message['data']['title'], message['data']['id'], context)
//             : _openNotification(
//                 message['view'], message['title'], message['id'], context);
//       },
//       onResume: (Map<String, dynamic> message) async {
//         print("onResume: $message");
//         Platform.isAndroid
//             ? _openNotification(message['data']['view'],
//                 message['data']['title'], message['data']['id'], context)
//             : _openNotification(
//                 message['view'], message['title'], message['id'], context);
//       },
//     );
//   }

//   Future onSelectNotifications(String payload, BuildContext context) async {
//     print(payload);
//     String type = payload.split('+')[0];
//     String name = payload.split('+')[1];
//     String id = payload.split('+')[2];
//     print('Value: $type Title : $name');
//     _openNotification(type, name, id, context);
//   }

//   Future _showNotificationWithDefaultSound(Map<String, dynamic> payload) async {
//     var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
//         '100', 'madaresco', 'Madaresco Notification Channel',
//         importance: Importance.High, priority: Priority.Default);
//     var iOSPlatformChannelSpecifics = new IOSNotificationDetails(
//         presentAlert: true, presentBadge: true, presentSound: true);
//     var platformChannelSpecifics = new NotificationDetails(
//          androidPlatformChannelSpecifics,
//         iOSPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//         100,
//         Platform.isIOS ? payload['title'] : payload['data']['title'],
//         Platform.isIOS ? payload['body'] : payload['data']['body'],
//         platformChannelSpecifics,
//         payload: Platform.isIOS
//             ? payload['view'] + '+' + payload['title'] + '+' + payload['id']
//             : payload['data']['view'] +
//                 '+' +
//                 payload['data']['title'] +
//                 '+' +
//                 payload['data']['id']);
//   }

//   void _openNotification(
//       String type, String name, String id, BuildContext context) {
//     switch (type) {
//       case "lessons":
//         navigatorKey.currentState.push(
//           MaterialPageRoute(
//             builder: (_) => ChangeNotifierProvider(
//               create: (_) => sl<LessonDetailsViewModel>(),
//               child: LessonDetailsPage(lessonID: int.parse(id)),
//             ),
//           ),
//         );
//         break;
//       case "conversation":
//         navigatorKey.currentState.push(
//           MaterialPageRoute(
//             builder: (_) => ChangeNotifierProvider(
//               create: (_) => sl<ChatViewModel>(),
//               child: ChatPage(url: "users/$id"),
//             ),
//           ),
//         );
//         break;
//       case "adminstration":
//         navigatorKey.currentState.push(
//           MaterialPageRoute(
//             builder: (_) => ChangeNotifierProvider(
//               create: (_) => sl<ChatViewModel>(),
//               child: ChatPage(url: "adminstration-room"),
//             ),
//           ),
//         );
//         break;
//       case "news":
//         navigatorKey.currentState.push(
//           MaterialPageRoute(
//             builder: (_) => ChangeNotifierProvider(
//               create: (_) => sl<SchoolNewsViewModel>(),
//               child: SchoolNewsPage(),
//             ),
//           ),
//         );
//         break;
//       case "school_media":
//         navigatorKey.currentState.push(
//           MaterialPageRoute(
//             builder: (_) => ChangeNotifierProvider(
//               create: (_) => sl<GallaryViewModel>(),
//               child: GallarysPage(),
//             ),
//           ),
//         );
//         break;
//       case "results":
//         navigatorKey.currentState.push(
//           MaterialPageRoute(
//             builder: (_) => ChangeNotifierProvider(
//               create: (_) => sl<ExamResultsViewModel>(),
//               child: ExamResultsPage(),
//             ),
//           ),
//         );
//         break;
//       case "attendance":
//         navigatorKey.currentState.push(
//           MaterialPageRoute(
//             builder: (_) => ChangeNotifierProvider(
//               create: (_) => sl<AbsenceViewModel>(),
//               child: AbsencePage(),
//             ),
//           ),
//         );
//         break;
//       case "exams":
//         navigatorKey.currentState.push(
//           MaterialPageRoute(
//             builder: (_) => ChangeNotifierProvider(
//               create: (_) => sl<ExamSubjectsViewModel>(),
//               child: ExamSubjectsPage(),
//             ),
//           ),
//         );
//         break;
//       case "schedules":
//         navigatorKey.currentState.push(
//           MaterialPageRoute(
//             builder: (_) => ChangeNotifierProvider(
//               create: (_) => sl<ScheduleViewModel>(),
//               child: ScheduleView(),
//             ),
//           ),
//         );
//         break;
//       case "installments":
//         print('Entered');
//         navigatorKey.currentState.push(
//           MaterialPageRoute(
//             builder: (_) => ChangeNotifierProvider(
//               create: (_) => sl<AnnualsViewModel>(),
//               child: AnnualsPage(),
//             ),
//           ),
//         );
//         break;
//       case "warnings":
//         print('warnings');
//         navigatorKey.currentState.push(MaterialPageRoute(
//           builder: (_) => ChangeNotifierProvider(
//             create: (_) => sl<StudentBehaviorViewModel>(),
//             child: StudentBehaviorPage(),
//           ),
//         ));
//         break;
//       case "admin_word":
//         print('admin word');
//         navigatorKey.currentState.push(
//           MaterialPageRoute(
//             builder: (_) => ChangeNotifierProvider(
//                 create: (_) => sl<ManagerWordViewModel>(),
//                 child: ManagerWordPage()),
//           ),
//         );
//         break;
//     }
//   }
// }
