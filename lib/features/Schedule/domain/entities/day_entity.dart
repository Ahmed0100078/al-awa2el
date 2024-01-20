import 'package:equatable/equatable.dart';

class DayEntity extends Equatable {
  final String arname, enname;
  final int no;
  final bool isOpen;

  const DayEntity({
    required this.arname,
    required this.enname,
    required this.no,
    required this.isOpen,
  });

  @override
  List<Object> get props => [arname, enname, no, isOpen];
}
