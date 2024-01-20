import 'package:equatable/equatable.dart';

class GallaryDetailsEntity extends Equatable {
  final String name;
  final List<String> images;

  const GallaryDetailsEntity({
    required this.name,
    required this.images,
  });

  @override
  List<Object> get props => [name, images];
}
