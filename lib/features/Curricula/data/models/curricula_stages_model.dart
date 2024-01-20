import 'package:madaresco/features/Curricula/domain/entities/filter_entity.dart';

class CurriculaStagesModel extends FilterEntity {
  final Data ?data;

  CurriculaStagesModel({this.data}) : super(filters: data!.options!);

  factory CurriculaStagesModel.fromJson(Map<String, dynamic> json) {
    return CurriculaStagesModel(
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  final String ?label;
  final List<Option> ?options;

  Data({this.label, this.options});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      label: json['label'],
      options: json['options'] != null
          ? (json['options'] as List).map((i) => Option.fromJson(i)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Option extends Filters {
  final int id;
  final String name;

  Option({required this.id, required this.name}) : super(name: name, id: id);

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
