import 'package:flutter/material.dart';
import 'package:madaresco/Util/SharedPrefernce.dart';
import 'package:madaresco/core/constant.dart';
import 'package:madaresco/core/language/app_loclaizations.dart';
import 'package:madaresco/features/Login/data/remote/models/login_model.dart';
import 'package:madaresco/features/OnlineLessons/domain/entities/online_lessons_entity.dart';
import 'package:madaresco/features/liveSession/presentation/pages/zoomMeetingWidget.dart';

class OnlineLessonRow extends StatelessWidget {
  final OnlineLessons lessonData;
  final bool isTeacher;

  const OnlineLessonRow({required this.lessonData, this.isTeacher = false});

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: lessonData.onlineLessons
          .map(
            (e) => Padding(
              padding: EdgeInsets.all(8.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0)),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            e.lessonTitle,
                            style: TextStyle(
                                color: kAccentColor,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: <Widget>[
                              Image.asset(
                                'assets/images/clock2.png',
                                height: 20.0,
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                lessonData.lessonDate,
                                style: TextStyle(
                                    color: Color(0xFF6A6A6A),
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                        ],
                      )),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Image.asset(
                                'assets/images/user2.png',
                                height: 20.0,
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                e.teacherName,
                                style: TextStyle(
                                    color: Color(0xFF6A6A6A),
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          GestureDetector(
                            onTap: () async {
                              // int id;
                              LoginModel? model =
                                  await SharedPreference.getLoginModel();

                              /// TODO: Understand usage of this:
                              // if (!isTeacher) {
                              //   id = model!.data!.id!;
                              // }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MeetingWidget(
                                          userId: model!.data!.name,
                                          meetingId: "${e.meetingRoom.id}",
                                          meetingPassword:
                                              "${e.meetingRoom.password}",
                                          meetingTitle: "${e.lessonTitle}",
                                        )),
                              );
                            },
                            behavior: HitTestBehavior.translucent,
                            child: Material(
                              borderRadius: BorderRadius.circular(10.0),
                              color: kAccentColor,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  local.translate('go_to_lesson'),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
