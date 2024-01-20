import 'package:equatable/equatable.dart';

class SubjectEntity extends Equatable {
  final List<SubjectData> subjects;
  final String next;

  const SubjectEntity({required this.subjects, required this.next});

  @override
  List<Object> get props => [subjects, next];
}

class SubjectData {
  final String name, image;

  final int id, count;

  List<Object> get props => [name, image, id, count];

  const SubjectData(
      {required this.name,
      required this.image,
      required this.id,
      required this.count});
}
