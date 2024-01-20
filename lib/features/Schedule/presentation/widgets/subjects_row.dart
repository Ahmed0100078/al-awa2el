import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:madaresco/core/constant.dart';
import 'package:madaresco/core/language/app_loclaizations.dart';
import 'package:madaresco/features/Schedule/domain/entities/schedule_entity.dart';

// الملف ده
class SubjectsRow extends StatelessWidget {
  final ScheduleSubject subjects;

  SubjectsRow({
    required this.subjects,
  });

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    log('subjects.time. ${subjects.time.runtimeType}');
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black45),
          borderRadius: BorderRadius.circular(16.0),
        ),
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image.asset(
                        'assets/images/outline.png',
                        height: 19,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        local.translate('subject'),
                        style: TextStyle(
                            color: kAccentColor, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Flexible(
                        child: Text(
                          subjects.subjectn,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image.asset(
                        'assets/images/man2.png',
                        height: 19,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        local.translate('teacher2'),
                        style: TextStyle(
                            color: kAccentColor, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Flexible(
                        child: Text(
                          subjects.teachern,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 5.0,
            ),
            Row(
              children: <Widget>[
                subjects.classroom != ""
                    ? Expanded(
                        flex: 4,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              local.translate('class_room'),
                              style: TextStyle(
                                  color: kAccentColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Flexible(
                              child: Text(
                                subjects.classroom,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                            )
                          ],
                        ),
                      )
                    : SizedBox(),
                SizedBox(
                  width: 5.0,
                ),
                subjects.division != ""
                    ? Expanded(
                        flex: 3,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              local.translate('sub_grade'),
                              style: TextStyle(
                                  color: kAccentColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Flexible(
                              child: Text(
                                subjects.division,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                            )
                          ],
                        ),
                      )
                    : SizedBox(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
