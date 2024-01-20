import 'package:flutter/material.dart';
import 'package:madaresco/core/constant.dart';
import 'package:madaresco/core/language/app_loclaizations.dart';
import 'package:madaresco/features/AllLessons/domain/entities/all_lessons_entity.dart';

import 'lesson_row.dart';

class AllLessonsRow extends StatelessWidget {
  final LessonsData lessonsData;

  const AllLessonsRow({
    required this.lessonsData,
  });

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '${local.translate('home_work_title')}',
                style:
                    TextStyle(color: kAccentColor, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                lessonsData.date,
                style: TextStyle(color: Colors.black),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: lessonsData.lessonList
                .map((e) => LessonRow(lesson: e))
                .toList(),
          )
        ],
      ),
    );
  }
}
