import 'package:madaresco/features/AllLessons/domain/entities/all_lessons_entity.dart';

// ignore: must_be_immutable
class AllLessonsModel extends AllLessonsEntity {
  final List<Data>? data;
  final Links? links;
  final Meta? meta;

  AllLessonsModel({this.data, this.links, this.meta})
      : super(lessons: data!, next: links!.next ?? "");

  factory AllLessonsModel.fromJson(Map<String?, dynamic> json) {
    return AllLessonsModel(
      data: json['data'] != null
          ? (json['data'] as List).map((i) => Data.fromJson(i)).toList()
          : null,
      links: json['links'] != null ? Links.fromJson(json['links']) : null,
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
    );
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
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
  final String? first;
  final String? last;
  final String? prev;
  final String? next;

  Links({this.first, this.last, this.prev, this.next});

  factory Links.fromJson(Map<String?, dynamic> json) {
    return Links(
      first: json['first'],
      last: json['last'] != null ? json['last'] : null,
      prev: json['prev'] != null ? json['prev'] : null,
      next: json['next'] != null ? json['next'] : null,
    );
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['first'] = this.first;
    data['next'] = this.next;
    if (this.last != null) {
      data['last'] = this.last;
    }
    if (this.prev != null) {
      data['prev'] = this.prev;
    }
    return data;
  }
}

class Data extends LessonsData {
  final String date;
  final List<Lesson>? lessons;

  Data({required this.date, this.lessons})
      : super(date: date, lessonList: lessons!);

  factory Data.fromJson(Map<String?, dynamic> json) {
    print(json);
    return Data(
      date: json['date'],
      lessons: json['lessons'] != null
          ? (json['lessons'] as List).map((i) => Lesson.fromJson(i)).toList()
          : null,
    );
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['date'] = this.date;
    if (this.lessons != null) {
      data['lessons'] = this.lessons!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Lesson extends Lessons {
  // final int id;
  // final String name;
  // final String? description;
  final bool? isNew;
  final List<Images>? images;
  final List<Attatchments>? attachments;
  final Teacher? teacher;
  // final Section? section;
  final String? createdAt;
  final Videos? video;
  final Audios? audio;

  Lesson(
      {required super.name,
      required super.subject,
      required super.desc,
      required super.id,
      // this.description,
      this.isNew,
      this.images,
      this.attachments,
      this.teacher,
      super.section,
      this.createdAt,
      this.video,
      this.audio})
      : super(image: subject!.avatar!);

  factory Lesson.fromJson(Map<String?, dynamic> json) {
    return Lesson(
      id: json['id'],
      name: json['name'],
      desc: json['description'],
      isNew: json['is_new'],
      images: json['images'] != null
          ? (json['images'] as List).map((i) => Images.fromJson(i)).toList()
          : null,
      attachments: json['attachments'] != null
          ? (json['attachments'] as List)
              .map((i) => Attatchments.fromJson(i))
              .toList()
          : null,
      teacher:
          json['teacher'] != null ? Teacher.fromJson(json['teacher']) : null,
      subject:
          json['subject'] != null ? Subject.fromJson(json['subject']) : null,
      section:
          json['section'] != null ? Section.fromJson(json['section']) : null,
      createdAt: json['created_at'],
      video: json['video'] != null ? Videos.fromJson(json['video']) : null,
      audio: json['audio'] != null ? Audios.fromJson(json['audio']) : null,
    );
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.desc;
    data['is_new'] = this.isNew;
    data['created_at'] = this.createdAt;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.attachments != null) {
      data['attachments'] = this.attachments!.map((v) => v.toJson()).toList();
    }
    if (this.teacher != null) {
      data['teacher'] = this.teacher!.toJson();
    }
    if (this.subject != null) {
      data['subject'] = this.subject!.toJson();
    }
    if (this.section != null) {
      data['section'] = this.section!.toJson();
    }
    if (this.video != null) {
      data['video'] = this.video!.toJson();
    }
    if (this.audio != null) {
      data['audio'] = this.audio!.toJson();
    }
    return data;
  }
}

class Teacher {
  final int? id;
  final String? name;
  final String? email;
  final String? mobile;
  final String? type;
  final String? about;
  final String? avatar;
  final bool? isConnected;
  final int? unseenCoversationsCount;
  final School? school;
  final Links? links;

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
      this.school,
      this.links});

  factory Teacher.fromJson(Map<String?, dynamic> json) {
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
      links: json['links'] != null ? Links.fromJson(json['links']) : null,
    );
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
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
    if (this.links != null) {
      data['links'] = this.links!.toJson();
    }
    return data;
  }
}

class School {
  final int? id;
  final String? name;
  final String? logo;
  final String? schoolCode;

  School({this.id, this.name, this.logo, this.schoolCode});

  factory School.fromJson(Map<String?, dynamic> json) {
    return School(
      id: json['id'],
      name: json['name'],
      logo: json['logo'],
      schoolCode: json['school_code'],
    );
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['school_code'] = this.schoolCode;
    return data;
  }
}

class LinksX {
  final Profile? profile;
  final Chat? chat;

  LinksX({this.profile, this.chat});

  factory LinksX.fromJson(Map<String?, dynamic> json) {
    return LinksX(
      profile:
          json['profile'] != null ? Profile.fromJson(json['profile']) : null,
      chat: json['chat'] != null ? Chat.fromJson(json['chat']) : null,
    );
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    if (this.chat != null) {
      data['chat'] = this.chat!.toJson();
    }
    return data;
  }
}

class Profile {
  final String? url;
  final String? type;

  Profile({this.url, this.type});

  factory Profile.fromJson(Map<String?, dynamic> json) {
    return Profile(
      url: json['url'],
      type: json['type'],
    );
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['url'] = this.url;
    data['type'] = this.type;
    return data;
  }
}

class Chat {
  final String? url;
  final String? type;

  Chat({this.url, this.type});

  factory Chat.fromJson(Map<String?, dynamic> json) {
    return Chat(
      url: json['url'],
      type: json['type'],
    );
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['url'] = this.url;
    data['type'] = this.type;
    return data;
  }
}

class Section {
  final int? id;
  final String? name;

  Section({this.id, this.name});

  factory Section.fromJson(Map<String?, dynamic> json) {
    return Section(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Subject {
  final int? id;
  final String? name;
  final String? avatar;
  final int? newlyLessonsCount;

  Subject({this.id, this.name, this.avatar, this.newlyLessonsCount});

  factory Subject.fromJson(Map<String?, dynamic> json) {
    return Subject(
      id: json['id'],
      name: json['name'],
      avatar: json['avatar'],
      newlyLessonsCount: json['newly_lessons_count'],
    );
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['newly_lessons_count'] = this.newlyLessonsCount;
    return data;
  }
}

class Meta {
  final int? currentPage;
  final int? from;
  final String? path;
  final int? perPage;
  final int? to;

  Meta({this.currentPage, this.from, this.path, this.perPage, this.to});

  factory Meta.fromJson(Map<String?, dynamic> json) {
    return Meta(
      currentPage: json['current_page'],
      from: json['from'],
      path: json['path'],
      perPage: json['per_page'],
      to: json['to'],
    );
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['current_page'] = this.currentPage;
    data['from'] = this.from;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['to'] = this.to;
    return data;
  }
}

class Attatchments {
  final int? id;
  final String? url;
  final String? name;
  final String? type;
  final int? size;
  final String? collection;
  final Links? links;

  Attatchments(
      {this.id,
      this.url,
      this.name,
      this.type,
      this.size,
      this.collection,
      this.links});

  factory Attatchments.fromJson(Map<String?, dynamic> json) {
    return Attatchments(
      id: json['id'],
      url: json['url'],
      name: json['name'],
      type: json['type'],
      size: json['size'],
      collection: json['collection'],
      links: json['links'] != null ? Links.fromJson(json['links']) : null,
    );
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['name'] = this.name;
    data['type'] = this.type;
    data['size'] = this.size;
    data['collection'] = this.collection;
    if (this.links != null) {
      data['links'] = this.links!.toJson();
    }
    return data;
  }
}

class DLinks {
  final Delete? delete;

  DLinks({this.delete});

  factory DLinks.fromJson(Map<String?, dynamic> json) {
    return DLinks(
      delete: json['delete'] != null ? Delete.fromJson(json['delete']) : null,
    );
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    if (this.delete != null) {
      data['delete'] = this.delete!.toJson();
    }
    return data;
  }
}

class Delete {
  final String? href;
  final String? method;

  Delete({this.href, this.method});

  factory Delete.fromJson(Map<String?, dynamic> json) {
    return Delete(
      href: json['href'],
      method: json['method'],
    );
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['href'] = this.href;
    data['method'] = this.method;
    return data;
  }
}

class Images {
  final int? id;
  final String? url;
  final String? name;
  final String? type;
  final int? size;
  final String? collection;
  final ILinks? links;

  Images(
      {this.id,
      this.url,
      this.name,
      this.type,
      this.size,
      this.collection,
      this.links});

  factory Images.fromJson(Map<String?, dynamic> json) {
    return Images(
      id: json['id'],
      url: json['url'],
      name: json['name'],
      type: json['type'],
      size: json['size'],
      collection: json['collection'],
      links: json['links'] != null ? ILinks.fromJson(json['links']) : null,
    );
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['name'] = this.name;
    data['type'] = this.type;
    data['size'] = this.size;
    data['collection'] = this.collection;
    if (this.links != null) {
      data['links'] = this.links!.toJson();
    }
    return data;
  }
}

class ILinks {
  final Delete? delete;

  ILinks({this.delete});

  factory ILinks.fromJson(Map<String?, dynamic> json) {
    return ILinks(
      delete: json['delete'] != null ? Delete.fromJson(json['delete']) : null,
    );
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    if (this.delete != null) {
      data['delete'] = this.delete!.toJson();
    }
    return data;
  }
}

class Videos {
  final int? id;
  final String? url;
  final String? name;
  final String? type;
  final int? size;
  final String? collection;
  final Details? details;
  final Links? links;

  Videos(
      {this.id,
      this.url,
      this.name,
      this.type,
      this.size,
      this.collection,
      this.details,
      this.links});

  factory Videos.fromJson(Map<String?, dynamic> json) {
    return Videos(
      id: json['id'],
      url: json['url'],
      name: json['name'],
      type: json['type'],
      size: json['size'],
      collection: json['collection'],
      details:
          json['details'] != null ? Details.fromJson(json['details']) : null,
      links: json['links'] != null ? Links.fromJson(json['links']) : null,
    );
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['name'] = this.name;
    data['type'] = this.type;
    data['size'] = this.size;
    data['collection'] = this.collection;
    if (this.details != null) {
      data['details'] = this.details!.toJson();
    }
    if (this.links != null) {
      data['links'] = this.links!.toJson();
    }
    return data;
  }
}

class Details {
  final String? thumb;
  final String? width;
  final String? height;
  final String? ratio;
  final String? duration;

  Details({this.thumb, this.width, this.height, this.ratio, this.duration});

  factory Details.fromJson(Map<String?, dynamic> json) {
    return Details(
      thumb: json['thumb'],
      width: json['width'] != null ? json['width'] : null,
      height: json['height'] != null ? json['height'] : null,
      ratio: json['ratio'] != null ? json['ratio'] : null,
      duration: json['duration'] != null ? json['duration'] : null,
    );
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['thumb'] = this.thumb;
    if (this.width != null) {
      data['width'] = this.width;
    }
    if (this.height != null) {
      data['height'] = this.height;
    }
    if (this.ratio != null) {
      data['ratio'] = this.ratio;
    }
    if (this.duration != null) {
      data['duration'] = this.duration;
    }
    return data;
  }
}

class Audios {
  final int? id;
  final String? url;
  final String? name;
  final String? type;
  final int? size;
  final String? collection;
  final Details? details;
  final Links? links;

  Audios(
      {this.id,
      this.url,
      this.name,
      this.type,
      this.size,
      this.collection,
      this.details,
      this.links});

  factory Audios.fromJson(Map<String?, dynamic> json) {
    return Audios(
      id: json['id'],
      url: json['url'],
      name: json['name'],
      type: json['type'],
      size: json['size'],
      collection: json['collection'],
      details:
          json['details'] != null ? Details.fromJson(json['details']) : null,
      links: json['links'] != null ? Links.fromJson(json['links']) : null,
    );
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['name'] = this.name;
    data['type'] = this.type;
    data['size'] = this.size;
    data['collection'] = this.collection;
    if (this.details != null) {
      data['details'] = this.details!.toJson();
    }
    if (this.links != null) {
      data['links'] = this.links!.toJson();
    }
    return data;
  }
}
