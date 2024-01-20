import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madaresco/core/language/app_loclaizations.dart';
import 'package:madaresco/features/Supervisor/data/remote/data_sources/Supervisor_Data_Sources.dart';
import 'package:madaresco/features/Supervisor/data/remote/models/Supervisor_model.dart';
import 'package:madaresco/features/Supervisor/presentation/widgets/custom_card_container.dart';
import 'package:madaresco/features/Supervisor/presentation/widgets/custom_text_container.dart';
import 'package:madaresco/features/Supervisor/presentation/widgets/superVisorDrawer.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../core/Network/network.dart';
import '../../../../core/notification_handler.dart';
import '../../../../injection_container.dart';

class FatherPage extends StatefulWidget {
  @override
  _FatherPageState createState() => _FatherPageState();
}

class _FatherPageState extends State<FatherPage> {
  SupervisorModel? vm;
  bool isLoading = true;
  final GlobalKey<ScaffoldState> scaffoldKey2 = new GlobalKey<ScaffoldState>();
  getData() async {
    vm =
        await SupervisorRemoteDataSourceImpl(network: sl()).getSupervisorInfo();
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
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
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
        getData();
      },
      child: Scaffold(
        key: scaffoldKey2,
        drawer: SideSuperVisorMenu(),
        body: isLoading
            ? ModalProgressHUD(
                child: Container(),
                inAsyncCall: isLoading,
              )
            : Stack(
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
                                const Color(0xFF001068),
                                const Color(0xFF001068),
                              ],
                            )),
                          ),
                          actions: [
                            GestureDetector(
                              child: Image.asset('assets/images/clipboard.png'),
                            ),
                          ],
                          leading: GestureDetector(
                            onTap: () {
                              scaffoldKey2.currentState!.openDrawer();
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
                            local.translate('superior'),
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
                    child: Stack(clipBehavior: Clip.none, children: [
                      Material(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        )),
                        child: Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              SizedBox(height: 70),
                              CustomTextContainer(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 90.0),
                                text: '${vm!.data!.name}',
                              ),
                              SizedBox(height: 16),
                              Expanded(
                                child: ListView.builder(
                                    itemCount: vm!.data!.students!.length,
                                    itemBuilder: (context, index) => CustomCardCotnaienr(
                                        model: vm!.data!.students![index],
                                        imgLink:
                                            vm!.data!.students![index].avatar!,
                                        childName:
                                            '${vm!.data!.students![index].name}',
                                        schoolName:
                                            '${vm!.data!.students![index].school!.name}',
                                        studentClass:
                                            '${vm!.data!.students![index].section!.name}')),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned.fill(
                        top: -50,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: vm!.data!.avatar == null
                                    ? Image.asset(
                                        'assets/images/placeholder.png',
                                        width: 110,
                                        height: 110,
                                        fit: BoxFit.fill,
                                      )
                                    : Container(
                                        child: FadeInImage.assetNetwork(
                                            fit: BoxFit.fill,
                                            width: 110,
                                            height: 110,
                                            placeholder:
                                                'assets/images/placeholder.png',
                                            image: vm!.data!.avatar!),
                                      )),
                          ),
                        ),
                      )
                    ]),
                  ),
                ],
              ),
      ),
    );
  }
}
