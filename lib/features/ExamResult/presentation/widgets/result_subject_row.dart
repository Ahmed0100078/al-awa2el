import 'package:flutter/material.dart';
import 'package:madaresco/core/constant.dart';
import 'package:madaresco/features/ExamResult/domain/entities/exam_result_entity.dart';

class ResultSubjectRow extends StatelessWidget {
  final SubjectsEntity _subject;

  ResultSubjectRow({
    required SubjectsEntity subject,
  }) : _subject = subject;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.grey)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  _subject.subjectName,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        bottomLeft: Radius.circular(10.0)),
                    color: (_subject.succeed && _subject.subjectTotal != 0)? kAccentColor: Colors.red,),
                child: Center(
                  child: Text(
                    _subject.subjectTotal.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
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
