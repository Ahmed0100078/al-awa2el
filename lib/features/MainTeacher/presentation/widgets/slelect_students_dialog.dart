import 'package:flutter/material.dart';
import 'package:madaresco/core/constant.dart';
import 'package:madaresco/core/language/app_loclaizations.dart';
import 'package:madaresco/features/AddOnlineLesson/domain/entities/students_entity.dart';
import 'package:madaresco/features/AddOnlineLesson/presentation/manager/add_online_lesson_view_model.dart';

void showStudentsDialog(
    BuildContext context, AddOnlineLessonViewModel vm) async {
  Dialog alertDialog = Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16.0)),
    ),
    child: StudentsDialog(vm),
  );
  await showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return ScaleTransition(scale: a1, child: alertDialog);
      },
      transitionDuration: Duration(milliseconds: 250),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return SizedBox();
      });
}

class StudentsDialog extends StatefulWidget {
  final AddOnlineLessonViewModel vm;

  StudentsDialog(this.vm);

  @override
  _StudentsDialogState createState() => _StudentsDialogState();
}

class _StudentsDialogState extends State<StudentsDialog> {
  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            child: ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 10,
                  );
                },
                itemCount: widget.vm.studentEntity.students.length + 1,
                itemBuilder: (context, index) {
                  if (index == widget.vm.studentEntity.students.length) {
                    return ValueListenableBuilder(
                        valueListenable: widget.vm.paginationLoading,
                        builder: (context, bool ploading, child) {
                          return buildProgressIndicator(ploading);
                        });
                  } else {
                    return studentRow(
                        student: widget.vm.studentEntity.students[index]);
                  }
                }),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(kAccentColor),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0))),
              ),
              child: Text(
                local.translate('select'),
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
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

  Widget studentRow({Students? student}) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (!student.isSelected) {
          student.isSelected = true;
          widget.vm.addStudent(student);
        } else {
          student.isSelected = false;
          widget.vm.removeStudent(student);
        }
        setState(() {});
      },
      child: Container(
        decoration: BoxDecoration(
          color: student!.isSelected ? kAccentColor : Colors.white,
          border: Border.all(
              color: student.isSelected ? Colors.white : Color(0xFFAFAFAF)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
        child: Text(
          student.name,
          style: TextStyle(
              color: student.isSelected ? Colors.white : Color(0xFFAFAFAF),
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
