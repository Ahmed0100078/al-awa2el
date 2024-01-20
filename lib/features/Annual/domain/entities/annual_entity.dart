import 'package:equatable/equatable.dart';

class AnnualEntity extends Equatable {
  final List<Annuals> paids, partialyPaid, notPaid;

  const AnnualEntity({
    required this.paids,
    required this.partialyPaid,
    required this.notPaid,
  });

  @override
  List<Object> get props => [paids, partialyPaid, notPaid];
}

class Annuals extends Equatable {
  final dynamic date, amount;

  const Annuals({
    required this.date,
    required this.amount,
  });

  @override
  List<Object> get props => [date, amount];
}
