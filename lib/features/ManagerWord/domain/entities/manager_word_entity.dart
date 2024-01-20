import 'package:equatable/equatable.dart';

class ManagerWordEntity extends Equatable {
  final String image, name, word;

  const ManagerWordEntity({
    this.image = "",
    this.name = "",
    this.word = "",
  });

  @override
  List<Object> get props => [image, name, word];
}
