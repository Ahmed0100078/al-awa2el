import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madaresco/core/constant.dart';
import 'package:madaresco/core/language/app_loclaizations.dart';
import 'package:madaresco/features/Login/presentation/manager/LoginViewModel.dart';
import 'package:madaresco/features/MadarescoLessonDetails/presentation/manager/madaresco_lesson_details_view_model.dart';
import 'package:madaresco/features/OpeningScreen/OpeningScreen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../../main.dart';

class MadarescoLessonDetailsPage extends StatefulWidget {
  final int _id;

  MadarescoLessonDetailsPage({
    required int id,
  }) : _id = id;

  @override
  _MadarescoLessonDetailsPageState createState() =>
      _MadarescoLessonDetailsPageState();
}

class _MadarescoLessonDetailsPageState
    extends State<MadarescoLessonDetailsPage> {
  bool isFullScreen = false;

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    MadarescoLessonDetailsViewModel vm =
        Provider.of<MadarescoLessonDetailsViewModel>(context);
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
    vm.id = widget._id;
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: vm.loading,
          builder: (context, bool loading, child) {
            return ModalProgressHUD(inAsyncCall: loading, child: child!);
          },
          child: YoutubePlayerBuilder(
            builder: (context, player) {
              return Stack(
                clipBehavior: Clip.none,
                fit: StackFit.expand,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      height: 140,
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 14.0),
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
                            local.translate('lesson_inner'),
                            style: GoogleFonts.cairo(
                                fontSize: 16.0, fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 100,
                    bottom: 0,
                    right: 10,
                    left: 10,
                    child: Material(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              SizedBox(
                                height: 26.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0),
                                child: Material(
                                  borderRadius: BorderRadius.circular(16.0),
                                  color: kAccentColor,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 8.0),
                                    child: Text(
                                      vm.entity.lessonTitle,
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
                              Text(
                                local.translate('lesson_video'),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: kAccentColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              vm.controller != null
                                  ? Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                          border:
                                              Border.all(color: Colors.grey)),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                          child: player))
                                  : SizedBox(),
                              SizedBox(
                                height: 16.0,
                              ),
                              Text(
                                local.translate('lesson_desc'),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: kAccentColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16.0),
                                      border: Border.all(color: Colors.grey)),
                                  padding: EdgeInsets.all(20.0),
                                  child: Text(
                                    vm.entity.lessonDescription,
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
            onEnterFullScreen: () {
              vm.controller!.pause();
              setState(() {
                isFullScreen = true;
              });
            },
            onExitFullScreen: () {
              setState(() {
                isFullScreen = false;
              });
            },
            player: YoutubePlayer(
              controller: vm.controller!,
              onReady: () {
                print('READY');
              },
            ),
          )),
    );
  }
}
