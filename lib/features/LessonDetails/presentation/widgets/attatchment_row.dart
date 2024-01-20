import 'dart:io';
import 'package:flutter/material.dart';
import 'package:madaresco/core/language/app_loclaizations.dart';
import 'package:madaresco/features/LessonDetails/domain/entities/lesson_details_entity.dart';
import 'package:madaresco/features/LessonDetails/presentation/manager/lesson_details_view_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AttatchmentRow extends StatefulWidget {
  final Attach attach;
  final AppLocalizations local;

  AttatchmentRow({required this.attach, required this.local});

  @override
  _AttatchmentRowState createState() => _AttatchmentRowState();
}

class _AttatchmentRowState extends State<AttatchmentRow> {
  // FlutterLocalNotificationsPlugin ?flutterLocalNotificationsPlugin;
  LessonDetailsViewModel? vm;

  // Future _showNotificationWithDefaultSound(
  //     String fileName, String path, AppLocalizations local) async {
  //   var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
  //       '100', 'new_art_channel',channelDescription: 'New Art Notification Channel',
  //       icon: 'notificationlogo',
  //       importance: Importance.high, priority: Priority.defaultPriority);
  //   var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
  //   var platformChannelSpecifics = new NotificationDetails(
  //        android: androidPlatformChannelSpecifics,
  //      iOS: iOSPlatformChannelSpecifics);
  //   print('$path');
  //   await flutterLocalNotificationsPlugin!.show(
  //       100,
  //       local.translate('downloaded'),
  //       local.translate('downloaded') + '  ' + '$fileName',
  //       platformChannelSpecifics,
  //       payload: path);
  // }

  // Future<bool?> requestPremssion() async {
  //   await [
  //     Permission.storage,
  //   ].request();
  //   if (await Permission.storage.request().isGranted) {
  //     print('granted');
  //     return true;
  //   } else if (await Permission.storage.request().isDenied) {
  //     Fluttertoast.showToast(
  //         msg: 'يجب منح التطبيق الاذن لحفظ الملفات',
  //         toastLength: Toast.LENGTH_SHORT);
  //
  //     Map<Permission, PermissionStatus> statuses = await [
  //       Permission.storage,
  //     ].request();
  //     return await Permission.storage.request().isGranted;
  //   }
  // }

  // Future<void> downloadFile(
  //     String fileLink, String name, AppLocalizations local) async {
  //   var pr = ProgressDialog(context,
  //       type: ProgressDialogType.download,
  //       isDismissible: false,
  //       showLogs: true);
  //   Dio dio = Dio();
  //   Directory ?tempDir = await getExternalStorageDirectory();
  //   String fullPath = tempDir!.path + "/$name";
  //
  //   try {
  //     pr.show();
  //     dio.download(fileLink, Platform.isAndroid ? fullPath : '',
  //         onReceiveProgress: (rec, total) {
  //       pr.update(
  //         progress: ((rec / total) * 100).toDouble(),
  //         message: local.translate('download_message'),
  //         progressWidget: Container(
  //             padding: EdgeInsets.all(8.0),
  //             child: CircularProgressIndicator(
  //               value: rec.toDouble(),
  //             )),
  //         maxProgress: 100.0,
  //         progressTextStyle: TextStyle(
  //             color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w400),
  //         messageTextStyle: TextStyle(
  //             color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w600),
  //       );
  //     }).then((resposne) async {
  //       // await MediaStore.saveFile(fullPath);
  //       print(fullPath);
  //       pr.hide();
  //       Fluttertoast.showToast(msg: local.translate('downloaded'));
  //       _showNotificationWithDefaultSound(name, fullPath, local);
  //     });
  //   } catch (e) {
  //     print(e);
  //     pr.hide().then((value) {
  //       Fluttertoast.showToast(msg: local.translate('download_error'));
  //     });
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //
  //   flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  //   var initilaizeAndroid = AndroidInitializationSettings('notificationlogo');
  //   var initilaizeIos = IOSInitializationSettings();
  //   var initilaizationSettings =
  //       InitializationSettings( android: initilaizeAndroid,iOS: initilaizeIos);
  //   flutterLocalNotificationsPlugin!.initialize(initilaizationSettings,
  //       onSelectNotification: onSelectNotifications);
  // }

  // Future onSelectNotifications(String ?payload) async {
  //   try {
  //     // OpenResult result = await OpenFile.open(payload);
  //     // if (result.type == ResultType.done) {}
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    vm = Provider.of<LessonDetailsViewModel>(context);
    return GestureDetector(
      onTap: () async {
        if (Platform.isAndroid) {
          await launchUrl(Uri.parse(widget.attach.url));
        } else {
          final bool nativeAppLaunchSucceeded = await launchUrl(
            Uri.parse(widget.attach.url),
            mode: LaunchMode.externalNonBrowserApplication,
          );
          if (!nativeAppLaunchSucceeded) {
            await launchUrl(
              Uri.parse(widget.attach.url),
              mode: LaunchMode.inAppWebView,
            );
          }
        }
        // requestPremssion().then((value) {
        //   if (value!) {
        //     downloadFile(widget.attach.url, widget.attach.name, widget.local);
        //   }
        // });
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(16.0)),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 16.0,
            ),
            Expanded(
              child: Text(
                widget.attach.name,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
            Image.asset(
              'assets/images/server.png',
              width: 90,
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
