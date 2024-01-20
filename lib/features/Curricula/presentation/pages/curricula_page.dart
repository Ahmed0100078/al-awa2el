import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logging/logging.dart';
import 'package:madaresco/core/language/app_loclaizations.dart';
import 'package:madaresco/features/Curricula/domain/entities/filter_entity.dart';
import 'package:madaresco/features/Curricula/presentation/manager/curricula_view_model.dart';
import 'package:madaresco/features/Curricula/presentation/widgets/curriculas_row.dart';
import 'package:madaresco/features/Login/presentation/manager/LoginViewModel.dart';
import 'package:madaresco/features/OpeningScreen/OpeningScreen.dart';
import 'package:madaresco/features/TeacherOpeningScreen/teacher_opening_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '../../../../main.dart';

// ignore: must_be_immutable
class CurriculaPage extends StatelessWidget {
  final ScrollController _scrollController = new ScrollController();
  CurriculaViewModel? vm;
  final Logger _logger = Logger('CurriculaPage');

  CurriculaPage() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _logger.info('last');
        if (vm!.entity.next.isNotEmpty) {
          vm!.getCurricula(pagination: true);
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    vm = Provider.of<CurriculaViewModel>(context);
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
                      local.translate('curricula'),
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
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: Colors.grey),
                        ),
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        child: DropdownButton<Filters>(
                          value: vm!.selectedStage.id == null
                              ? null
                              : vm!.selectedStage,
                          underline: Container(),
                          hint: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(local.translate('choose_grade')),
                          ),
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          ),
                          iconSize: 30,
                          style: TextStyle(color: Colors.black),
                          isExpanded: true,
                          onChanged: (Filters? newValue) {
                            vm!.selectedStage = newValue!;
                          },
                          items: vm!.stages.filters
                              .map<DropdownMenuItem<Filters>>((Filters value) {
                            return DropdownMenuItem<Filters>(
                              value: value,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  value.name!,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: Colors.grey),
                        ),
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        child: DropdownButton<Filters>(
                          value: vm!.selectedGrade.id == null
                              ? null
                              : vm!.selectedGrade,
                          underline: Container(),
                          hint: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(local.translate('choose_class')),
                          ),
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          ),
                          iconSize: 30,
                          style: TextStyle(color: Colors.black),
                          isExpanded: true,
                          onChanged: (Filters? newValue) {
                            vm!.selectedGrade = newValue!;
                          },
                          items: vm!.grades.filters
                              .map<DropdownMenuItem<Filters>>((Filters value) {
                            return DropdownMenuItem<Filters>(
                              value: value,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  value.name!,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: Colors.grey),
                        ),
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        child: DropdownButton<String>(
                          value:
                              vm!.selectedTerm == '' ? null : vm!.selectedTerm,
                          underline: Container(),
                          hint: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(local.translate('select_term')),
                          ),
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          ),
                          iconSize: 30,
                          style: TextStyle(color: Colors.black),
                          isExpanded: true,
                          onChanged: (String? newValue) {
                            vm!.selectedTerm = newValue!;
                          },
                          items: vm!.terms
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  local.translate(value),
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: Colors.grey),
                        ),
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        child: DropdownButton<Filters>(
                          value: vm!.selectedSubject.id == null
                              ? null
                              : vm!.selectedSubject,
                          underline: Container(),
                          hint: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(local.translate('choose_subject')),
                          ),
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          ),
                          iconSize: 30,
                          style: TextStyle(color: Colors.black),
                          isExpanded: true,
                          onChanged: (Filters? newValue) {
                            vm!.selectedSubject = newValue!;
                          },
                          items: vm!.subjects.filters
                              .map<DropdownMenuItem<Filters>>((Filters value) {
                            return DropdownMenuItem<Filters>(
                              value: value,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  value.name!,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Expanded(
                        child: vm!.entity.curricals.isNotEmpty
                            ? GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2),
                                controller: _scrollController,
                                itemBuilder: (context, index) {
                                  if (index == vm!.entity.curricals.length) {
                                    return ValueListenableBuilder(
                                        valueListenable: vm!.paginationLoading,
                                        builder:
                                            (context, bool ploading, child) {
                                          return buildProgressIndicator(
                                              ploading);
                                        });
                                  } else {
                                    return CurriculasRow(
                                        item: vm!.entity.curricals[index]);
                                  }
                                },
                                itemCount: vm!.entity.curricals.length + 1,
                              )
                            : Center(
                                child: Text(
                                  local.translate('no_curricula'),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                      ),
                    ],
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
