import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

import '../../SharedPrefernce.dart';

Future<void> getAndSaveFCMToken() async {
  String? token = await FirebaseMessaging.instance.getToken();
  log('fcm token   $token');
  SharedPreference.setNotificationToken(token!);
}
