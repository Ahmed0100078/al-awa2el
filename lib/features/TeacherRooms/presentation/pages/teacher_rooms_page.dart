import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logging/logging.dart';
import 'package:madaresco/core/language/app_loclaizations.dart';
import 'package:madaresco/core/widgets/custom_drop_down_menu_button.dart';
import 'package:madaresco/features/OpeningScreen/OpeningScreen.dart';
import 'package:madaresco/features/TeacherOpeningScreen/teacher_opening_screen.dart';
import 'package:madaresco/features/TeacherRooms/data/models/GradesListModel.dart'
    as gradesModel;
import 'package:madaresco/features/TeacherRooms/data/models/SectionsListModel.dart'
    as sectionModel;
import 'package:madaresco/features/TeacherRooms/presentation/manager/get%20Grades%20cubit/getgrades_cubit.dart';
import 'package:madaresco/features/TeacherRooms/presentation/manager/get%20sections%20cubit/get_sections_cubit.dart';
import 'package:madaresco/features/TeacherRooms/presentation/manager/getFilterd%20students%20cubit/getfilterdstudents_cubit.dart';
import 'package:madaresco/features/TeacherRooms/presentation/widgets/teacher_rooms_row.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class TeacherRoomsPage extends StatefulWidget {
  @override
  _TeacherRoomsPageState createState() => _TeacherRoomsPageState();
}

class _TeacherRoomsPageState extends State<TeacherRoomsPage> {
  final ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    print('$sectionId   $gradeId');
    _logger.info('last');
    isFilter = false;
    sectionId = null;
    gradeId = null;
    setState(() {});
    super.initState();
  }

  final Logger _logger = Logger('TeacherRoomsPage');
  bool isFilter = false;
  bool isLoading = false;
  int? gradeId;
  int? sectionId;

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    return Scaffold(
      body: Stack(
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
                    local.translate('students'),
                    style: GoogleFonts.cairo(
                        fontSize: 16.0, fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 150,
            //bottom: 0,
            right: 10,
            left: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BlocBuilder<GetgradesCubit, GetgradesState>(
                  builder: (context, state) {
                    print(state);
                    if (state is GetgradesInitial) {
                      BlocProvider.of<GetgradesCubit>(context).getGrades();
                    }
                    if (state is GetgradesSuccess) {
                      List<String> stringItems = [];
                      state.gradesModel.grades!.forEach((element) {
                        stringItems.add(element.name!);
                      });
                      return SizedBox(
                        height: 100,
                        width: 150,
                        child: CustomDropDownMenuButton<gradesModel.Grade>(
                            // validator: (gradesModel.Grade value) {},
                            onChanged: (value) {
                              gradeId = value.id;
                              isFilter = true;
                              setState(() {});
                              if (gradeId != null && sectionId != null)
                                BlocProvider.of<GetfilterdstudentsCubit>(
                                        context)
                                    .getFilterdStudents(
                                        grade: gradeId!, section: sectionId!);
                            },
                            items: state.gradesModel.grades!,
                            hintText: 'الصف'),
                      );
                    } else if (state is GetgradesLoading) {
                      return buildProgressIndicator(false);
                    } else if (state is GetgradesFailier) {
                      return Center(
                        child: Text(state.errMsg),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                BlocBuilder<GetSectionsCubit, GetSectionsState>(
                  builder: (context, state) {
                    print(state);
                    if (state is GetSectionsInitial) {
                      BlocProvider.of<GetSectionsCubit>(context).getSections();
                    }
                    if (state is GetSectionsSucess) {
                      List<sectionModel.Section>? sections =
                          state.sectionsModel.sections;
                      return SizedBox(
                        height: 100,
                        width: 150,
                        child: CustomDropDownMenuButton<sectionModel.Section>(
                            // validator: (sectionModel.Section value) {},
                            onChanged: (value) {
                              sectionId = value.id;
                              isFilter = true;
                              setState(() {});

                              if (gradeId != null && sectionId != null)
                                BlocProvider.of<GetfilterdstudentsCubit>(
                                        context)
                                    .getFilterdStudents(
                                        grade: gradeId!, section: sectionId!);
                            },
                            items: sections!,
                            hintText: 'الشعبة'),
                      );
                    } else if (state is GetgradesLoading) {
                      return buildProgressIndicator(false);
                    } else if (state is GetSectionsFailier) {
                      return Center(
                        child: Text(state.errMsg),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                )
              ],
            ),
          ),
          if (isFilter)
            Positioned(
              top: 250,
              bottom: 0,
              right: 10,
              left: 10,
              child: ModalProgressHUD(
                inAsyncCall: isLoading,
                progressIndicator: buildProgressIndicator(true),
                child: BlocConsumer<GetfilterdstudentsCubit,
                    GetfilterdstudentsState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    print(state);
                    if (state is GetfilterdstudentsLoading) {
                      isLoading = true;
                      return buildProgressIndicator(true);
                    }
                    if (state is GetfilterdstudentsSuccess) {
                      isLoading = false;
                      if (state.studentModel.students!.isEmpty ||
                          state.studentModel.students!.length == 0)
                        return Center(
                          child: Text(
                            'لا توجد نتائج',
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      else
                        return Material(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          )),
                          child: Container(
                            padding: EdgeInsets.all(20.0),
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              controller: _scrollController,
                              itemBuilder: (context, index) {
                                return FilterTeacherRoomsRow(
                                    item: state.studentModel.students![index]);
                              },
                              itemCount: state.studentModel.students!.length,
                            ),
                          ),
                        );
                    }
                    return SizedBox();
                  },
                ),
              ),
            ),
          if (!isFilter)
            Center(
              child: Text(
                'اختر الصف والشعبه ليظهر لك الطلاب',
                style: TextStyle(color: Colors.black),
              ),
            ),
        ],
        // ),
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
