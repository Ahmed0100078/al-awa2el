import 'package:flutter/material.dart';
import 'package:madaresco/core/constant.dart';
import 'package:madaresco/features/ExamSchedule/presentation/manager/exam_schedule_view_model.dart';
import 'package:madaresco/features/ExamSchedule/presentation/pages/exam_schedule_page.dart';
import 'package:madaresco/features/ExamSubjects/domain/entities/exam_subjects_entity.dart';
import 'package:provider/provider.dart';
import '../../../../injection_container.dart';
import '../../../../main.dart';

class ExamSubjectsRow extends StatelessWidget {
  final ExamSubjectsData _examSubjectsData;

  ExamSubjectsRow({
    required ExamSubjectsData examSubjectsData,
  }) : _examSubjectsData = examSubjectsData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        mainNavigatorKey.currentState!.push(
          MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                create: (_) => sl<ExamScheduleViewModel>(),
                child: ExamSchedulePage(examId: _examSubjectsData.id)),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Card(
          elevation: 6,
          color: kAccentColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _examSubjectsData.name,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
