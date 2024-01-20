import 'package:equatable/equatable.dart';

class SchoolNewsDetailsEntity extends Equatable {
  final String image, date, title, description;
  final int number;

  const SchoolNewsDetailsEntity({
    required this.image,
    required this.date,
    required this.title,
    required this.description,
    required this.number,
  });

  @override
  List<Object> get props => [image, date, title, description, number];
}
