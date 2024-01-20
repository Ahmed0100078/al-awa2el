import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madaresco/core/constant.dart';
import 'package:madaresco/core/language/app_loclaizations.dart';
import 'package:madaresco/features/AddOnlineLesson/presentation/manager/add_online_lesson_view_model.dart'; 
import 'package:madaresco/features/Login/presentation/manager/LoginViewModel.dart';
import 'package:madaresco/features/MainTeacher/presentation/widgets/slelect_students_dialog.dart';
import 'package:madaresco/features/MainTeacher/presentation/widgets/students_row.dart';
import 'package:madaresco/features/Register/domain/entities/item_entity.dart';
import 'package:madaresco/features/TeacherOpeningScreen/teacher_opening_screen.dart';
import 'package:madaresco/features/UploadLesson/presentation/widgets/upload_completed_dialog.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '../../../../main.dart';

class AddOnlineLessonPage extends StatefulWidget {
  @override
  State<AddOnlineLessonPage> createState() => _AddOnlineLessonPageState();
}

class _AddOnlineLessonPageState extends State<AddOnlineLessonPage> {
  GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    AddOnlineLessonViewModel vm =
        Provider.of<AddOnlineLessonViewModel>(context);
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
                            padding: EdgeInsets.symmetric(horizontal: 14.0),
                            child: Icon(Icons.arrow_forward_ios)),
                      ),
                    ],
                    leading: GestureDetector(
                      onTap: () {
                        teacherScaffoldKey.currentState!.openDrawer();
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
                      local.translate('add_online_lesson'),
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
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            local.translate('lesson_title'),
                            style: TextStyle(
                              color: kAccentColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return local.translate('title_error');
                              }
                              return null;
                            },
                            onChanged: (value) {
                              vm.lessonTitle = value;
                            },
                            style: TextStyle(color: Colors.black, fontSize: 12),
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(color: Colors.grey)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(color: Colors.grey)),
                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:
                                        BorderSide(color: Colors.grey))),
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          Text(
                            local.translate('choose_grade'),
                            style: TextStyle(
                              color: kAccentColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: Colors.grey),
                            ),
                            height: 40,
                            padding: EdgeInsets.symmetric(horizontal: 5.0),
                            child: DropdownButton<Item>(
                              value: vm.selectedStage.id == null
                                  ? null
                                  : vm.selectedStage,
                              underline: Container(),
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black,
                              ),
                              iconSize: 30,
                              style: TextStyle(color: Colors.black),
                              isExpanded: true,
                              onChanged: (Item? newValue) {
                                vm.selectedStage = newValue!;
                              },
                              items: vm.stageEntity.items!
                                  .map<DropdownMenuItem<Item>>((Item value) {
                                return DropdownMenuItem<Item>(
                                  value: value,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Text(value.name!),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            local.translate('choose_class'),
                            style: TextStyle(
                              color: kAccentColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: Colors.grey),
                            ),
                            height: 40,
                            padding: EdgeInsets.symmetric(horizontal: 5.0),
                            child: DropdownButton<Item>(
                              value: vm.selectedGrades.id == null
                                  ? null
                                  : vm.selectedGrades,
                              underline: Container(),
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black,
                              ),
                              iconSize: 30,
                              style: TextStyle(color: Colors.black),
                              isExpanded: true,
                              onChanged: (Item? newValue) {
                                vm.selectedGrades = newValue!;
                              },
                              items: vm.grades.items!
                                  .map<DropdownMenuItem<Item>>((Item value) {
                                return DropdownMenuItem<Item>(
                                  value: value,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.0),
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
                            height: 16,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Text(
                                      local.translate('choose_subject'),
                                      style: TextStyle(
                                        color: kAccentColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: Border.all(color: Colors.grey),
                                      ),
                                      height: 40,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5.0),
                                      child: DropdownButton<Item>(
                                        value: vm.selectedSubject.id == null
                                            ? null
                                            : vm.selectedSubject,
                                        underline: Container(),
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.black,
                                        ),
                                        iconSize: 30,
                                        style: TextStyle(color: Colors.black),
                                        isExpanded: true,
                                        onChanged: (Item? newValue) {
                                          vm.selectedSubject = newValue!;
                                        },
                                        items: vm.subjects.items!
                                            .map<DropdownMenuItem<Item>>(
                                                (Item value) {
                                          return DropdownMenuItem<Item>(
                                            value: value,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.0),
                                              child: Text(
                                                value.name!,
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 16.0,
                              ),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Text(
                                    local.translate('choose_sub_grade'),
                                    style: TextStyle(
                                      color: kAccentColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    height: 40,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5.0),
                                    child: DropdownButton<Item>(
                                      value: vm.selectedSection.id == null
                                          ? null
                                          : vm.selectedSection,
                                      underline: Container(),
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.black,
                                      ),
                                      iconSize: 30,
                                      style: TextStyle(color: Colors.black),
                                      isExpanded: true,
                                      onChanged: (Item? newValue) {
                                        vm.selectedSection = newValue!;
                                        vm.getStudents(vm.selectedSection.id!);
                                      },
                                      items: vm.sections.items!
                                          .map<DropdownMenuItem<Item>>(
                                              (Item value) {
                                        return DropdownMenuItem<Item>(
                                          value: value,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Text(
                                              value.name!,
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ))
                            ],
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          AnimatedSwitcher(
                            duration: Duration(milliseconds: 800),
                            transitionBuilder: (child, animation) {
                              var tween = Tween<Offset>(
                                      begin: Offset(1.0, 0.0),
                                      end: Offset(0.0, 0.0))
                                  .animate(CurvedAnimation(
                                      parent: animation,
                                      curve: Curves.bounceOut));
                              return SlideTransition(
                                position: tween,
                                child: child,
                              );
                            },
                            child: vm.selectedSection.id != null
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Text(
                                        local.translate('choose_student'),
                                        style: TextStyle(
                                          color: kAccentColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          border:
                                              Border.all(color: Colors.grey),
                                        ),
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  children: vm.students
                                                      .map((e) => StudentsRow(
                                                          students: e))
                                                      .toList(),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5.0,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                showStudentsDialog(context, vm);
                                              },
                                              behavior:
                                                  HitTestBehavior.translucent,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: kAccentColor),
                                                  padding: EdgeInsets.all(4.0),
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  )
                                : SizedBox(),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          TextButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                vm.addLesson().then((value) {
                                  if (value) {
                                    showThankYouDialog(context);
                                  }
                                });
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              decoration: kBoxDecoration.copyWith(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(87.0))),
                              padding:
                                  const EdgeInsets.fromLTRB(20, 10, 20, 10),
                              child: Center(
                                  child: Text(local.translate('publish'),
                                      style: TextStyle(fontSize: 20))),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
