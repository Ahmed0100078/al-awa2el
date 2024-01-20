import 'package:flutter/material.dart';
import 'package:madaresco/core/constant.dart';
import 'package:madaresco/features/MadarescoLessonDetails/presentation/manager/madaresco_lesson_details_view_model.dart';
import 'package:madaresco/features/MadarescoLessonDetails/presentation/pages/madaresco_lesson_details_page.dart';
import 'package:madaresco/features/MadarescoLessons/domain/entities/madaresco_lessons_entitiy.dart';
import 'package:madaresco/injection_container.dart';
import 'package:provider/provider.dart';
import '../../../../main.dart';

class MadarescoLessonDetailsRow extends StatelessWidget {
  final LessonEntity _lesson;

  MadarescoLessonDetailsRow({
    required LessonEntity lesson,
  }) : _lesson = lesson;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        mainNavigatorKey.currentState!.push(
          MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
              create: (_) => sl<MadarescoLessonDetailsViewModel>(),
              child: MadarescoLessonDetailsPage(id: _lesson.id),
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: Colors.grey),
          ),
          padding:
              EdgeInsets.only(left: 10.0, right: 16.0, top: 8.0, bottom: 8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      _lesson.lessonName,
                      style: TextStyle(
                          color: kAccentColor, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      children: <Widget>[
                        Image.asset(
                          'assets/images/user2.png',
                          height: 16.0,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          _lesson.teacherName,
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    )
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Container(
                  color: kAccentColor,
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                  child: Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 60,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
