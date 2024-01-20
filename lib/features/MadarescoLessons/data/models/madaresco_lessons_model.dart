import 'package:madaresco/features/MadarescoLessons/domain/entities/madaresco_lessons_entitiy.dart';

// ignore: must_be_immutable
class MadarescoLessonsModel extends MadarescoLessonsEntity {
  final List<Data> ?data;
  final Links ?links;
  final Meta ?meta;

  MadarescoLessonsModel({this.data, this.links, this.meta})
      : super(lessons: data!, next: links!.next??'');

  factory MadarescoLessonsModel.fromJson(Map<String ?, dynamic> json) {
    return MadarescoLessonsModel(
      data: json['data'] != null
          ? (json['data'] as List).map((i) => Data.fromJson(i)).toList()
          : null,
      links: json['links'] != null ? Links.fromJson(json['links']) : null,
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
    );
  }

  Map<String ?, dynamic> toJson() {
    final Map<String ?, dynamic> data = new Map<String ?, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.links != null) {
      data['links'] = this.links!.toJson();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class Links {
  final String ? first;
  final String ? last;
  final String ? prev;
  final String ? next;

  Links({this.first, this.last, this.prev, this.next});

  factory Links.fromJson(Map<String ?, dynamic> json) {
    return Links(
      first: json['first'],
      last: json['last'] != null ? json['last'] : null,
      prev: json['prev'] != null ? json['prev'] : null,
      next: json['next'] != null ? json['next'] : null,
    );
  }

  Map<String ?, dynamic> toJson() {
    final Map<String ?, dynamic> data = new Map<String ?, dynamic>();
    data['first'] = this.first;
    if (this.last != null) {
      data['last'] = this.last;
    }
    if (this.prev != null) {
      data['prev'] = this.prev;
    }
    if (this.next != null) {
      data['next'] = this.next;
    }
    return data;
  }
}

class Data extends LessonsEntity {
  final String  date;
  final List<Lesson> ?lessons;

  Data({required this.date, this.lessons}) : super(lessonsentity: lessons!, date: date);

  factory Data.fromJson(Map<String ?, dynamic> json) {
    return Data(
      date: json['date'],
      lessons: json['lessons'] != null
          ? (json['lessons'] as List).map((i) => Lesson.fromJson(i)).toList()
          : null,
    );
  }

  Map<String ?, dynamic> toJson() {
    final Map<String ?, dynamic> data = new Map<String ?, dynamic>();
    data['date'] = this.date;
    if (this.lessons != null) {
      data['lessons'] = this.lessons!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Lesson extends LessonEntity {
  final int  id;
  final String ? name;
  final String ? description;
  final String ? youtubeId;
  final bool ? isNew;
  final Subject ?subject;
  final String ? createdAt;
  final Teacher ?teacher;

  Lesson(
      {required this.id,
      this.name,
      this.description,
      this.youtubeId,
      this.isNew,
      this.subject,
      this.createdAt,
      this.teacher})
      : super(teacherName: teacher!.name!, lessonName: name!, image: subject!.avatar!, id: id);

  factory Lesson.fromJson(Map<String ?, dynamic> json) {
    return Lesson(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      youtubeId: json['youtube_id'],
      isNew: json['is_new'],
      subject: json['subject'] != null ? Subject.fromJson(json['subject']) : null,
      createdAt: json['created_at'],
      teacher: json['teacher'] != null ? Teacher.fromJson(json['teacher']) : null,
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
    if (this.teacher != null) {
      data['teacher'] = this.teacher!.toJson();
    }
    return data;
  }
}

class Teacher {
  final int ? id;
  final String ? name;
  final String ? email;
  final String ? mobile;
  final String ? type;
  final String ? about;
  final String ? avatar;
  final bool ? isConnected;
  final int ? unseenCoversationsCount;
  final School ?school;

  Teacher(
      {this.id,
      this.name,
      this.email,
      this.mobile,
      this.type,
      this.about,
      this.avatar,
      this.isConnected,
      this.unseenCoversationsCount,
      this.school});

  factory Teacher.fromJson(Map<String ?, dynamic> json) {
    return Teacher(
      id: json['id'],
      name: json['name'],
      email: json['email'] != null ? json['email'] : null,
      mobile: json['mobile'] != null ? json['mobile'] : null,
      type: json['type'],
      about: json['about'] != null ? json['about'] : null,
      avatar: json['avatar'],
      isConnected: json['is_connected'],
      unseenCoversationsCount: json['unseen_coversations_count'],
      school: json['school'] != null ? School.fromJson(json['school']) : null,
    );
  }

  Map<String ?, dynamic> toJson() {
    final Map<String ?, dynamic> data = new Map<String ?, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['avatar'] = this.avatar;
    data['is_connected'] = this.isConnected;
    data['unseen_coversations_count'] = this.unseenCoversationsCount;
    if (this.email != null) {
      data['email'] = this.email;
    }
    if (this.mobile != null) {
      data['mobile'] = this.mobile;
    }
    if (this.about != null) {
      data['about'] = this.about;
    }
    if (this.school != null) {
      data['school'] = this.school!.toJson();
    }
    return data;
  }
}

class School {
  final int ? id;
  final String ? name;
  final String ? logo;
  final String ? schoolCode;

  School({this.id, this.name, this.logo, this.schoolCode});

  factory School.fromJson(Map<String ?, dynamic> json) {
    return School(
      id: json['id'],
      name: json['name'],
      logo: json['logo'],
      schoolCode: json['school_code'],
    );
  }

  Map<String ?, dynamic> toJson() {
    final Map<String ?, dynamic> data = new Map<String ?, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['school_code'] = this.schoolCode;
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

class Meta {
  final int ? currentPage;
  final int ? from;
  final String ? path;
  final int ? perPage;
  final int ? to;

  Meta({this.currentPage, this.from, this.path, this.perPage, this.to});

  factory Meta.fromJson(Map<String ?, dynamic> json) {
    return Meta(
      currentPage: json['current_page'],
      from: json['from'],
      path: json['path'],
      perPage: json['per_page'],
      to: json['to'],
    );
  }

  Map<String ?, dynamic> toJson() {
    final Map<String ?, dynamic> data = new Map<String ?, dynamic>();
    data['current_page'] = this.currentPage;
    data['from'] = this.from;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['to'] = this.to;
    return data;
  }
}
