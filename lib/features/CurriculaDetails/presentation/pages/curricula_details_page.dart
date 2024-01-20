import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madaresco/core/constant.dart';
import 'package:madaresco/core/language/app_loclaizations.dart';
import 'package:madaresco/features/CurriculaDetails/presentation/manager/curricula_details_view_model.dart';
import 'package:madaresco/features/Login/presentation/manager/LoginViewModel.dart';
import 'package:madaresco/features/OpeningScreen/OpeningScreen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../main.dart';

class CurriculaDetailsPage extends StatefulWidget {
  final int _id;

  CurriculaDetailsPage({
    required int id,
  }) : _id = id;

  @override
  _CurriculaDetailsPageState createState() => _CurriculaDetailsPageState();
}

class _CurriculaDetailsPageState extends State<CurriculaDetailsPage> {
  bool openfile = false;

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    CurriculaDetailsViewModel vm =
        Provider.of<CurriculaDetailsViewModel>(context);
    vm.id = widget._id;

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
                      )),
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
                    leading: GestureDetector(
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
                    centerTitle: true,
                    title: Text(
                      local.translate('curricula'),
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
                    borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                )),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                        height: 26.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(16.0),
                          color: kAccentColor,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 8.0),
                            child: Text(
                              vm.entity.name,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0)),
                          elevation: 6,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: Image.network(
                              vm.entity.image,
                              height: 260,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 26.0,
                      ),
                      vm.entity.pdfLink.isNotEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () async {
                                    if (Platform.isAndroid) {
                                      await launchUrl(
                                          Uri.parse(vm.entity.pdfLink));
                                    } else {
                                      final bool nativeAppLaunchSucceeded =
                                          await launchUrl(
                                        Uri.parse(vm.entity.pdfLink),
                                        mode: LaunchMode
                                            .externalNonBrowserApplication,
                                      );
                                      if (!nativeAppLaunchSucceeded) {
                                        await launchUrl(
                                          Uri.parse(vm.entity.pdfLink),
                                          mode: LaunchMode.inAppWebView,
                                        );
                                      }
                                    }
                                  },
                                  behavior: HitTestBehavior.translucent,
                                  child: Card(
                                    elevation: 6,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16.0)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                              local.translate('watch_book'),
                                              style: TextStyle(
                                                  color: kAccentColor),
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                color: Color(0xFFF3F3F3)),
                                            padding: EdgeInsets.all(10.0),
                                            child: Image.asset(
                                              'assets/images/bookshow.png',
                                              height: 35,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Platform.isAndroid
                                    ? GestureDetector(
                                        behavior: HitTestBehavior.translucent,
                                        onTap: () async {
                                          if (Platform.isAndroid) {
                                            await launchUrl(
                                                Uri.parse(vm.entity.pdfLink));
                                          } else {
                                            final bool
                                                nativeAppLaunchSucceeded =
                                                await launchUrl(
                                              Uri.parse(vm.entity.pdfLink),
                                              mode: LaunchMode
                                                  .externalNonBrowserApplication,
                                            );
                                            if (!nativeAppLaunchSucceeded) {
                                              await launchUrl(
                                                Uri.parse(vm.entity.pdfLink),
                                                mode: LaunchMode.inAppWebView,
                                              );
                                            }
                                          }
                                          // requestPremssion().then((value) {
                                          //   if (value!) {
                                          //     downloadFile(vm.entity.pdfLink,
                                          //         vm.entity.name, local);
                                          //   }
                                          // });
                                        },
                                        child: Card(
                                          elevation: 6,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16.0)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: Text(
                                                    local.translate(
                                                        'download_book'),
                                                    style: TextStyle(
                                                        color: kAccentColor),
                                                  ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      color: Color(0xFFF3F3F3)),
                                                  padding: EdgeInsets.all(10.0),
                                                  child: Image.asset(
                                                    'assets/images/bookdown.png',
                                                    height: 35,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    : SizedBox(),
                                SizedBox(
                                  height: 26.0,
                                ),
                              ],
                            )
                          : SizedBox()
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Future _showNotificationWithDefaultSound(
  //     String fileName, String path, AppLocalizations local) async {
  //   var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
  //       '100', 'your_schools_channel',channelDescription: 'YourSchools Notification Channle',
  //       icon: 'notificationlogo',
  //       importance: Importance.high, priority: Priority.defaultPriority);
  //   var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
  //   var platformChannelSpecifics = new NotificationDetails(
  //        android: androidPlatformChannelSpecifics,
  //        iOS: iOSPlatformChannelSpecifics);
  //   await flutterLocalNotificationsPlugin!.show(
  //     100,
  //     local.translate('downloaded'),
  //     local.translate('downloaded') + ' $fileName',
  //     platformChannelSpecifics,
  //     payload: path,
  //   );
  // }

  // ignore: missing_return
  // Future<bool?> requestPremssion() async {
  //   Map<Permission, PermissionStatus> statuses = await [
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
  //   try {
  //     pr.show();
  //     dio.download(
  //         fileLink, Platform.isAndroid ? '/storage/emulated/0/$name' : '',
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
  //     }).then((resposne) {
  //       pr.hide();
  //       Fluttertoast.showToast(msg: local.translate('downloaded'));
  //       _showNotificationWithDefaultSound(
  //           name, '/storage/emulated/0/$name', local);
  //       openfile = true;
  //     });
  //   } catch (e) {
  //     print(e);
  //     pr.hide().then((value) {
  //       Fluttertoast.showToast(msg: local.translate('download_error'));
  //     });
  //   }
  // }
}
