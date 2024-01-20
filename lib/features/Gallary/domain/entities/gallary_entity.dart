import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class GallaryEntity extends Equatable {
  final List<ItemEntity> gallarys;
  String next;

  GallaryEntity({
    required this.gallarys,
    required this.next,
  });

  @override
  List<Object> get props => [gallarys, next];
}

class ItemEntity extends Equatable {
  final String name, avatar;
  final int id;

  const ItemEntity(
      {required this.name, required this.avatar, required this.id});

  @override
  List<Object> get props => [id, name, avatar];
}
