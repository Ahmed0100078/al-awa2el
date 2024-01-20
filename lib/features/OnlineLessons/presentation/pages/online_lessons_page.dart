import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logging/logging.dart';
import 'package:madaresco/core/language/app_loclaizations.dart';
import 'package:madaresco/features/Login/presentation/manager/LoginViewModel.dart';
import 'package:madaresco/features/OnlineLessons/presentation/manager/online_lessons_view_model.dart';
import 'package:madaresco/features/OnlineLessons/presentation/widgets/online_lesson_row.dart';
import 'package:madaresco/features/OpeningScreen/OpeningScreen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '../../../../main.dart';

// ignore: must_be_immutable
class OnlineLessonsPage extends StatelessWidget {
  final bool isTeacher;
  final ScrollController _scrollController = new ScrollController();
  OnlineLessonsViewModel? vm;
  final Logger _logger = Logger('OnlineLessonsPage');

  OnlineLessonsPage({this.isTeacher = false}) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _logger.info('last');
        if (vm!.entity.next.isNotEmpty) {
          vm!.getOnlineLessons(true);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    vm = Provider.of<OnlineLessonsViewModel>(context);
    vm!.toast.addListener(() {
      if (vm!.toast.value.getContentIfNotHandled() != null) {
        if (vm!.toast.value.peekContent() == SERVER_FAILURE_MESSAGE) {
          Fluttertoast.showToast(msg: SERVER_FAILURE_MESSAGE);
        } else {
          Fluttertoast.showToast(
              msg: local.translate(vm!.toast.value.peekContent()));
        }
      }
    });
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: vm!.loading,
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
                height: 120,
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
                      behavior: HitTestBehavior.translucent,
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
                      local.translate('online_lessons'),
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
                )),
                child: Container(
                  child: vm!.entity.lessons.isNotEmpty
                      ? ListView.builder(
                          controller: _scrollController,
                          itemBuilder: (context, index) {
                            if (index == vm!.entity.lessons.length) {
                              return ValueListenableBuilder(
                                  valueListenable: vm!.paginationLoading,
                                  builder: (context, bool ploading, child) {
                                    return buildProgressIndicator(ploading);
                                  });
                            } else {
                              return OnlineLessonRow(
                                lessonData: vm!.entity.lessons[index],
                                isTeacher: isTeacher,
                              );
                            }
                          },
                          itemCount: vm!.entity.lessons.length + 1,
                        )
                      : Center(
                          child: Text(
                          local.translate('no_lessons'),
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProgressIndicator(bool isPaginationLoading) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Opacity(
          opacity: isPaginationLoading ? 1.0 : 00,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
