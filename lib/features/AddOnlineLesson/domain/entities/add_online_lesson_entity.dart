import 'package:equatable/equatable.dart';

class AddOnlineLessonEntity extends Equatable {
  final int sectionId, subjectId;
  final String name, link;
  final List<int> students;

  const AddOnlineLessonEntity({
    required this.sectionId,
    required this.subjectId,
    required this.name,
    required this.link,
    required this.students,
  });

  @override
  List<Object> get props => [sectionId, subjectId, name, link, students];
}
