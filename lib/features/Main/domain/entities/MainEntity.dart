import 'package:equatable/equatable.dart';

class MainEntity extends Equatable {
  final String name, avatar, school, section, grade, stage;
  final int appearResults;

  const MainEntity(
      {required this.name,
      required this.avatar,
      required this.appearResults,
      required this.school,
      required this.section,
      required this.grade,
      required this.stage});

  @override
  List<Object> get props =>
      [name, avatar, school, section, grade, appearResults];
}
