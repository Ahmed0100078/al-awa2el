import 'package:equatable/equatable.dart';
import '../../data/models/all_lessons_model.dart';

// ignore: must_be_immutable
class AllLessonsEntity extends Equatable {
  final List<LessonsData> lessons;
  String next;

  AllLessonsEntity({
    required this.lessons,
    required this.next,
  });

  @override
  List<Object> get props => [lessons, next];
}

class LessonsData extends Equatable {
  final String date;
  final List<Lessons> lessonList;

  const LessonsData({
    required this.date,
    required this.lessonList,
  });

  @override
  List<Object> get props => [date, lessonList];
}

class Lessons extends Equatable {
  final String name, desc, image;
  final Section? section;
  final Subject? subject;
  final int id;

  const Lessons( {required this.subject,
    required this.section,
    required this.name,
    required this.desc,
    required this.id,
    required this.image,
  });

  @override
  List<Object> get props => [name, desc, image, id];
}
