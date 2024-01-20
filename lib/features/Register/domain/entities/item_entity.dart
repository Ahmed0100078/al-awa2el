import 'package:equatable/equatable.dart';

class ItemsEntity extends Equatable {
  final List<Item>? items;

  const ItemsEntity({
    required this.items,
  });

  @override
  List<Object> get props => [items!];
}

class Item extends Equatable {
  final String? name;
  final int? id;

  const Item({
    required this.name,
    required this.id,
  });

  @override
  List<Object> get props => [name ?? '', id ?? 0];
}
