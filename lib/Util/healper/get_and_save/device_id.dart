import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import '../../SharedPrefernce.dart';
import 'dart:io';

Future<void> getAndSaveDeviceID() async {
  String identifier;
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  try {
    if (Platform.isAndroid) {
      var build = await deviceInfoPlugin.androidInfo;
      identifier = build.androidId;
      SharedPreference.setDeviceId(identifier);
      print('device id ${await SharedPreference.getDeviceId()}');
    } else if (Platform.isIOS) {
      var data = await deviceInfoPlugin.iosInfo;
      identifier = data.identifierForVendor;
      SharedPreference.setDeviceId(identifier);
      print('device id ${await SharedPreference.getDeviceId()}');
    }
  } on PlatformException {
    print('Failed to get platform version');
  }
}
