import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class MadarescoLessonsEntity extends Equatable {
  final List<LessonsEntity> lessons;
  String next;

  MadarescoLessonsEntity({
    required this.lessons,
    required this.next,
  });

  @override
  List<Object> get props => [lessons, next];
}

class LessonsEntity extends Equatable {
  final List<LessonEntity> lessonsentity;
  final String date;

  const LessonsEntity({
    required this.lessonsentity,
    required this.date,
  });

  @override
  List<Object> get props => [lessonsentity, date];
}

class LessonEntity extends Equatable {
  final String lessonName, teacherName, image;
  final int id;

  const LessonEntity({
    required this.lessonName,
    required this.teacherName,
    required this.id,
    required this.image,
  });

  @override
  List<Object> get props => [lessonName, teacherName, id, image];
}
