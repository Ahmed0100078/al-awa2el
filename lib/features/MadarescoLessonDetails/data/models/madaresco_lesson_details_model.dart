import 'package:madaresco/features/MadarescoLessonDetails/domain/entities/madaresco_lesson_details_entity.dart';

class MadarescoLessonDetailsModel extends MadarescoLessonDetailsEntity {
  final Data ?data;

  MadarescoLessonDetailsModel({this.data})
      : super(
            lessonTitle: data!.name!,
            lessonDescription: data.description!,
            youtubeId: data.youtubeId!);

  factory MadarescoLessonDetailsModel.fromJson(Map<String ?, dynamic> json) {
    return MadarescoLessonDetailsModel(
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }

  Map<String ?, dynamic> toJson() {
    final Map<String ?, dynamic> data = new Map<String ?, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  final int ? id;
  final String ? name;
  final String ? description;
  final String ? youtubeId;
  final bool ? isNew;
  final Subject ?subject;
  final String ? createdAt;

  Data(
      {this.id,
      this.name,
      this.description,
      this.youtubeId,
      this.isNew,
      this.subject,
      this.createdAt});

  factory Data.fromJson(Map<String ?, dynamic> json) {
    return Data(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      youtubeId: json['youtube_id'],
      isNew: json['is_new'],
      subject: json['subject'] != null ? Subject.fromJson(json['subject']) : null,
      createdAt: json['created_at'],
    );
  }

  Map<String ?, dynamic> toJson() {
    final Map<String ?, dynamic> data = new Map<String ?, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['youtube_id'] = this.youtubeId;
    data['is_new'] = this.isNew;
    data['created_at'] = this.createdAt;
    if (this.subject != null) {
      data['subject'] = this.subject!.toJson();
    }
    return data;
  }
}

class Subject {
  final int ? id;
  final String ? name;
  final String ? avatar;
  final int ? newlyLessonsCount;

  Subject({this.id, this.name, this.avatar, this.newlyLessonsCount});

  factory Subject.fromJson(Map<String ?, dynamic> json) {
    return Subject(
      id: json['id'],
      name: json['name'],
      avatar: json['avatar'],
      newlyLessonsCount: json['newly_lessons_count'],
    );
  }

  Map<String ?, dynamic> toJson() {
    final Map<String ?, dynamic> data = new Map<String ?, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['newly_lessons_count'] = this.newlyLessonsCount;
    return data;
  }
}
