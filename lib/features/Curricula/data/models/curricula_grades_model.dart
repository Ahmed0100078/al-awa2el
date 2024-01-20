import 'package:madaresco/features/Curricula/domain/entities/filter_entity.dart';

class CurriculaGradesModel extends FilterEntity {
  final Data ?data;

  CurriculaGradesModel({this.data}) : super(filters: data!.grades!.options!);

  factory CurriculaGradesModel.fromJson(Map<String, dynamic> json) {
    return CurriculaGradesModel(
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
  final int ?id;
  final String ?name;
  final Grades ?grades;

  Data({this.id, this.name, this.grades});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      name: json['name'],
      grades: json['grades'] != null ? Grades.fromJson(json['grades']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.grades != null) {
      data['grades'] = this.grades!.toJson();
    }
    return data;
  }
}

class Grades {
  final String ?label;
  final List<Option>? options;

  Grades({this.label, this.options});

  factory Grades.fromJson(Map<String, dynamic> json) {
    return Grades(
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

  Option({required this.id, required this.name}) : super(id: id, name: name);

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
