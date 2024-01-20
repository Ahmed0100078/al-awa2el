import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class TeacherRoomsEntity extends Equatable {
  final List<Students> students;
  String next;

  TeacherRoomsEntity({
    required this.students,
    required this.next,
  });

  @override
  List<Object> get props => [students, next];
}

class Students extends Equatable {
  final String name, image;
  final int id;

  const Students({
    required this.name,
    required this.image,
    required this.id,
  });

  @override
  List<Object> get props => [name, image, id];
}
