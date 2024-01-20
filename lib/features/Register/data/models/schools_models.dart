import 'package:madaresco/features/Register/domain/entities/item_entity.dart';

class SchoolModel extends ItemsEntity {
  final Data ?data;

  SchoolModel({this.data}) : super(items: data!.options);

  factory SchoolModel.fromJson(Map<String, dynamic> json) {
    return SchoolModel(
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
  final List<Option>? options;

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

class Option extends Item {
  final int ?id;
  final String ?name;
  final String ?email;
  final String ?logo;

  Option({this.id, this.name, this.email, this.logo}) : super(name: name, id: id);

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      logo: json['logo'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['logo'] = this.logo;
    return data;
  }
}
