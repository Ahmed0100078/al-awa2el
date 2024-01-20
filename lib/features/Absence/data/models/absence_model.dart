import 'package:madaresco/features/Absence/domain/entities/absence_entity.dart';

class AbsenceModel extends AbsenceEntity {
  final List<Data>? data;

  AbsenceModel({this.data}) : super(absenceData: data!);

  factory AbsenceModel.fromJson(Map<String, dynamic> json) {
    return AbsenceModel(
      data: json['data'] != null
          ? (json['data'] as List).map((i) => Data.fromJson(i)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data extends AbsenceData {
  final String day;
  final String date;
  final String ?status;
  final String ?statusFormated;

  Data({required this.day, required this.date, this.status, this.statusFormated})
      : super(day: day, date: date, statuses: statusFormated!);

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      day: json['day'],
      date: json['date'],
      status: json['status'],
      statusFormated: json['status_formated'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['date'] = this.date;
    data['status'] = this.status;
    data['status_formated'] = this.statusFormated;
    return data;
  }
}
