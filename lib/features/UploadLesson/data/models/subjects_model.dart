import 'package:madaresco/features/Register/domain/entities/item_entity.dart';

class SubjectsModel extends ItemsEntity {
  // final Data ?data;
  final List<Option>? options;
  SubjectsModel(
      {
      //this.data
      this.options})
      : super(
            //  items: data!.options
            items: options);

  factory SubjectsModel.fromJson(Map<String, dynamic> json) {
    return SubjectsModel(
      //  data: json['data'] != null ? Data.fromJson(json['data']) : null,
      options: json['data']['options'] != null
          ? (json['data']['options'] as List).map((i) => Option.fromJson(i)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // if (this.data != null) {
    //   data['data'] = this.data!.toJson();
    // }
    if (this.options != null) {
      data['data'] = this.options!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  final String? label;
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
  final int? id;
  final String? name;
  final String? avatar;
  final int? newlyLessonsCount;

  Option({this.id, this.name, this.avatar, this.newlyLessonsCount})
      : super(id: id, name: name);

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      id: json['id'],
      name: json['name'],
      avatar: json['avatar'],
      newlyLessonsCount: json['newly_lessons_count'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['newly_lessons_count'] = this.newlyLessonsCount;
    return data;
  }
}
