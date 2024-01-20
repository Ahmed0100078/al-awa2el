import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class CurriculaEntity extends Equatable {
  final List<Curricular> curricals;
  String next;

  CurriculaEntity({
    required this.curricals,
    required this.next,
  });

  @override
  List<Object> get props => [curricals, next];
}

class Curricular extends Equatable {
  final String name, photo;
  final int id;

  const Curricular({
    required this.name,
    required this.photo,
    required this.id,
  });

  @override
  List<Object> get props => [name, photo, id];
}
