import 'package:flutter/material.dart';
import 'package:madaresco/core/constant.dart';
import 'package:madaresco/features/AllLessons/domain/entities/all_lessons_entity.dart';
import 'package:madaresco/features/LessonDetails/presentation/manager/lesson_details_view_model.dart';
import 'package:madaresco/features/LessonDetails/presentation/pages/lesson_details_page.dart';
import 'package:madaresco/main.dart';
import 'package:provider/provider.dart';
import '../../../../injection_container.dart';

class LessonRow extends StatelessWidget {
  final Lessons lesson;

  const LessonRow({
    required this.lesson,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        mainNavigatorKey.currentState!.push(
          MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
              create: (_) => sl<LessonDetailsViewModel>(),
              child: NewLessonDetailsPage(lessonID: lesson.id),
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 6,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      lesson.name,
                      style: TextStyle(color: kAccentColor, fontSize: 14),
                    ),
                    SizedBox(
                      height: 2.0,
                    ),
                    Text(
                      lesson.section?.name ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                padding: EdgeInsets.all(5.0),
                child: Image.network(
                  lesson.image,
                  width: 40,
                  height: 40,
                  fit: BoxFit.fill,
                  errorBuilder: (context, x, y) {
                    return Image.asset(
                      'assets/images/bookshow.png',
                      width: 40,
                      height: 40,
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
