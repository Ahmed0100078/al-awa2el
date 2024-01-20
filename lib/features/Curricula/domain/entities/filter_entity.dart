import 'package:equatable/equatable.dart';

class FilterEntity extends Equatable {
  final List<Filters> filters;

  FilterEntity({
    required this.filters,
  });

  @override
  List<Object> get props => [filters];
}

class Filters extends Equatable {
  final int? id;
  final String? name;

  const Filters({
    this.id,
    this.name,
  });

  @override
  List<Object> get props => [id!, name!];
}
