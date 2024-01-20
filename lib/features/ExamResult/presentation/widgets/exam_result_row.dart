import 'package:flutter/material.dart';
import 'package:madaresco/core/constant.dart';
import 'package:madaresco/core/language/app_loclaizations.dart';
import 'package:madaresco/features/ExamResult/domain/entities/exam_result_entity.dart';
import 'package:madaresco/features/ExamResult/presentation/widgets/result_subject_row.dart';

class ExamResultRow extends StatelessWidget {
  final ExamEntity _exam;

  ExamResultRow({
    required ExamEntity exam,
  }) : _exam = exam;

  @override
  Widget build(BuildContext context) {
    // Added to change color
    Color color = kAccentColor;
    if(_exam.total< (_exam.total/2)) {
      color = Colors.red;
    }
    var local = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Stack(clipBehavior: Clip.none, children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: Colors.grey)),
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Text(
                      local.translate('subject_name'),
                      style: TextStyle(
                          color: kAccentColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    flex: 3,
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        local.translate('total'),
                        style: TextStyle(
                            color: color,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: _exam.subjects
                    .map((e) => ResultSubjectRow(subject: e))
                    .toList(),
              ),
              SizedBox(
                height: 16.0,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: kAccentColor),
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        local.translate('total_sum'),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      flex: 3,
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          _exam.total.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: -16,
          right: 16.0,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: kAccentColor,
            ),
            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 30),
            child: Text(
              _exam.examName,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ]),
    );
  }
}
