import 'package:equatable/equatable.dart';

class AboutAppEntity extends Equatable {
  final String about, name, showDeleteProfile, appearStudentDegrees;

  const AboutAppEntity(
      {required this.about,
      required this.name,
      required this.showDeleteProfile,
      required this.appearStudentDegrees});

  @override
  List<Object> get props =>
      [about, name, showDeleteProfile, appearStudentDegrees];
}
