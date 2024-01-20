import 'package:equatable/equatable.dart';
import 'package:madaresco/features/OnlineLessons/data/models/meetingRoom.dart';

// ignore: must_be_immutable
class OnlineLessonsEntity extends Equatable {
  final List<OnlineLessons> lessons;
  String next;

  OnlineLessonsEntity({
    required this.lessons,
    required this.next,
  });

  @override
  List<Object> get props => [lessons, next];
}

class OnlineLessons extends Equatable {
  final String lessonDate;
  final List<OnlineLesson> onlineLessons;

  const OnlineLessons({
    required this.lessonDate,
    required this.onlineLessons,
  });

  @override
  List<Object> get props => [onlineLessons, lessonDate];
}

class OnlineLesson extends Equatable {
  final String lessonTitle, teacherName, lessonLink, token, channelName;
  final int roomId, lessonId;
  final MeetingRoom meetingRoom;

  const OnlineLesson(
      {required this.lessonTitle,
      required this.teacherName,
      required this.lessonLink,
      required this.channelName,
      required this.token,
      required this.roomId,
      required this.lessonId,
      required this.meetingRoom});

  @override
  List<Object> get props => [
        lessonTitle,
        teacherName,
        lessonLink,
        channelName,
        token,
        roomId,
        lessonId,
        meetingRoom
      ];
}
