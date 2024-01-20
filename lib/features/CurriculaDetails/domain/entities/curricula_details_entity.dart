import 'package:equatable/equatable.dart';

class CurriculaDetailsEntity extends Equatable {
  final String name, image, pdfLink;

  const CurriculaDetailsEntity({
    required this.name,
    required this.image,
    required this.pdfLink,
  });

  @override
  List<Object> get props => [name, image, pdfLink];
}
