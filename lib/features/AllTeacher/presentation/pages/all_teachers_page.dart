import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logging/logging.dart';
import 'package:madaresco/core/language/app_loclaizations.dart';
import 'package:madaresco/features/AllTeacher/presentation/manager/all_teachers_view_model.dart';
import 'package:madaresco/features/AllTeacher/presentation/widgets/all_teachers_row.dart';
import 'package:madaresco/features/Login/presentation/manager/LoginViewModel.dart';
import 'package:madaresco/features/OpeningScreen/OpeningScreen.dart';
import 'package:madaresco/features/TeacherOpeningScreen/teacher_opening_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AllTeachersPage extends StatelessWidget {
  final ScrollController _scrollController = new ScrollController();
  AllTeachersViewModel? vm;
  final Logger _logger = Logger('AllTeachersPage');

  AllTeachersPage() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _logger.info('last');
        if (vm!.entity.next.isNotEmpty) {
          vm!.getAllTeachers(true);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    vm = Provider.of<AllTeachersViewModel>(context);
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
                    leading: GestureDetector(
                      onTap: () {
                        try {
                          scaffoldKey.currentState!.openDrawer();
                        } catch (e) {
                          teacherScaffoldKey.currentState!.openDrawer();
                        }
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
                      local.translate('contact_teachers'),
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
                  padding: EdgeInsets.all(20.0),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    controller: _scrollController,
                    itemBuilder: (context, index) {
                      if (index == vm!.entity.teachers.length) {
                        return ValueListenableBuilder(
                            valueListenable: vm!.paginationLoading,
                            builder: (context, bool ploading, child) {
                              return buildProgressIndicator(ploading);
                            });
                      } else {
                        return AllTeachersRow(item: vm!.entity.teachers[index]);
                      }
                    },
                    itemCount: vm!.entity.teachers.length + 1,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
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
