import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:madaresco/core/constant.dart';
import 'package:madaresco/features/AllLessons/presentation/manager/all_lessons_viewmode.dart';
import 'package:madaresco/features/AllLessons/presentation/pages/all_lessons_page.dart';
import 'package:madaresco/features/Subjects/domain/entities/subject_entity.dart';
import 'package:madaresco/main.dart';
import 'package:provider/provider.dart';
import '../../../../injection_container.dart';

class SubjectRow extends StatelessWidget {
  final SubjectData entity;

  const SubjectRow({
    required this.entity,
  });

  @override
  Widget build(BuildContext context) {
    print('entity.name ${entity.name} entity.count ${entity.count}');
    return GestureDetector(
      onTap: () {
        mainNavigatorKey.currentState!.push(
          MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
              create: (_) => sl<AllLessonsViewModel>(),
              child: AllLessonsPage(id: entity.id),
            ),
          ),
        );
      },
      behavior: HitTestBehavior.translucent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
        child: badges.Badge(
          position: badges.BadgePosition.topStart(),
          badgeAnimation: badges.BadgeAnimation.scale(),
          badgeContent: Text("${entity.count}"),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 1.5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0)),
                    child: Image.network(
                      entity.image,
                      fit: BoxFit.fill,
                      errorBuilder: (context, x, y) {
                        return Image.asset('assets/images/bookshow.png');
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: kAccentColor),
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Text(
                        entity.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: kAccentColor,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Teacher Subject (OnPressed Shows Sent HomeWorks)
class TeacherSubjectRow extends StatelessWidget {
  final SubjectData entity;

  const TeacherSubjectRow({
    required this.entity,
  });

  @override
  Widget build(BuildContext context) {
    print('entity.name ${entity.name} entity.count ${entity.count}');
    return GestureDetector(
      /// Push AllLessons Screen that includes sent homeworks
      onTap: () {
        mainNavigatorKey.currentState!.push(
          MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
              create: (_) => sl<AllLessonsViewModel>(),
              child: AllLessonsPage(id: entity.id),
            ),
          ),
        );
      },
      behavior: HitTestBehavior.translucent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1.5,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0)),
                  child: Image.network(
                    entity.image,
                    fit: BoxFit.fill,
                    errorBuilder: (context, x, y) {
                      return Image.asset('assets/images/bookshow.png');
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: kAccentColor),
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Text(
                      entity.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: kAccentColor,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
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
