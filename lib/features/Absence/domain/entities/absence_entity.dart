import 'package:equatable/equatable.dart';

class AbsenceEntity extends Equatable {
  final List<AbsenceData> absenceData;

  const AbsenceEntity({
    required this.absenceData,
  });

  @override
  List<Object> get props => [absenceData];
}

class AbsenceData extends Equatable {
  final String date, day, statuses;

  const AbsenceData({
    required this.date,
    required this.day,
    required this.statuses,
  });

  @override
  List<Object> get props => [date, day, statuses];
}
