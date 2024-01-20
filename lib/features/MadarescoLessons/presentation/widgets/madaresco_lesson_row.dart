import 'package:flutter/material.dart';
import 'package:madaresco/features/MadarescoLessons/domain/entities/madaresco_lessons_entitiy.dart';
import 'madaresco_lesson_details_row.dart';

class MadarescoLessonRow extends StatelessWidget {
  final LessonsEntity _lessonsData;

  MadarescoLessonRow({
    required LessonsEntity lessonsData,
  }) : _lessonsData = lessonsData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            _lessonsData.date,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _lessonsData.lessonsentity
                .map((e) => MadarescoLessonDetailsRow(lesson: e))
                .toList(),
          )
        ],
      ),
    );
  }
}
