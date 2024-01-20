import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class AllTeachersEntity extends Equatable {
  final List<Teachers> teachers;
  String next;

  AllTeachersEntity({
    required this.teachers,
    required this.next,
  });

  @override
  List<Object> get props => [teachers, next];
}

class Teachers extends Equatable {
  final String name, image;
  final int id;

  const Teachers({
    required this.name,
    required this.image,
    required this.id,
  });

  @override
  List<Object> get props => [name, image, id];
}
