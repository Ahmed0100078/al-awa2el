import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logging/logging.dart';
import 'package:madaresco/core/language/app_loclaizations.dart';
import 'package:madaresco/features/Login/presentation/manager/LoginViewModel.dart';
import 'package:madaresco/features/OpeningScreen/OpeningScreen.dart';
import 'package:madaresco/features/SchoolNews/presentation/manager/school_news_view_model.dart';
import 'package:madaresco/features/SchoolNews/presentation/widgets/school_news_row.dart';
import 'package:madaresco/features/TeacherOpeningScreen/teacher_opening_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class SchoolNewsPage extends StatefulWidget {
  final bool withBack;
  SchoolNewsPage({Key? key, this.withBack = true}) : super(key: key);

  @override
  _SchoolNewsPageState createState() => _SchoolNewsPageState();
}

class _SchoolNewsPageState extends State<SchoolNewsPage> {
  final ScrollController _scrollController = new ScrollController();
  SchoolNewsViewModel? vm;
  final Logger _logger = Logger('SchoolNewsPage');

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _logger.info('last');
        if (vm!.entity.next.isNotEmpty) {
          vm!.getSchoolNews(true);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    vm = Provider.of<SchoolNewsViewModel>(context);
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
                      widget.withBack
                          ? GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 14.0),
                                child: Icon(
                                  local.locale!.languageCode == "en"
                                      ? Icons.arrow_back_ios
                                      : Icons.arrow_forward_ios,
                                  color: Colors.white,
                                ),
                              ))
                          : Container()
                    ],
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
                      local.translate('school_news'),
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
                  child: ListView.builder(
                    controller: _scrollController,
                    itemBuilder: (context, index) {
                      if (index == vm!.entity.news.length) {
                        return ValueListenableBuilder(
                            valueListenable: vm!.paginationLoading,
                            builder: (context, bool ploading, child) {
                              return buildProgressIndicator(ploading);
                            });
                      } else {
                        return SchoolNewsRow(news: vm!.entity.news[index]);
                      }
                    },
                    itemCount: vm!.entity.news.length + 1,
                  ),
                ),
              ),
            )
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
