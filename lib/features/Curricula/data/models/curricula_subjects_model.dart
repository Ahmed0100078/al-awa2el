import 'package:madaresco/features/Curricula/domain/entities/filter_entity.dart';

class CurriculaSubjectsModel extends FilterEntity {
  final List<Data> ?data;

  CurriculaSubjectsModel({this.data}) : super(filters: data!);

  factory CurriculaSubjectsModel.fromJson(Map<String, dynamic> json) {
    return CurriculaSubjectsModel(
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

class Data extends Filters {
  final int id;
  final String name;
  final String? avatar;
  final int ?newlyLessonsCount;

  Data({required this.id, required this.name, this.avatar, this.newlyLessonsCount}) : super(id: id, name: name);

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
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
