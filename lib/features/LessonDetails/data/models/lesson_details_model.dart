import 'package:madaresco/features/LessonDetails/domain/entities/lesson_details_entity.dart';

class LessonDetailsModel extends LessonDetailsEntity {
  final Data? data;

  LessonDetailsModel({this.data})
      : super(
            name: data!.name!,
            date: data.createdAt!,
            images: data.images!,
            externalLink: data.externalLink ?? "",
            audio: data.audio ?? Audio(url: '', name: ''),
            attachments: data.attachments!,
            video: data.video ?? Video(url: '', name: '', thumb: ''),
            stage: data.stage,
            section: data.section,
            subject: data.subject,
            description: data.description!);

  factory LessonDetailsModel.fromJson(Map<String, dynamic> json) {
    return LessonDetailsModel(
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
  final int? id;
  final String? name;
  final String? externalLink;
  final String? description;
  final bool? isNew;
  final Videos? video;
  final Audios? audio;
  final List<Images>? images;
  final List<Attachments>? attachments;
  final Teacher? teacher;
  final Subject? subject;
  final Stage? stage;
  final Section? section;
  final String? createdAt;

  Data(
      {this.id,
      this.name,
      this.description,
      this.isNew,
      this.video,
      this.audio,
      this.images,
      this.attachments,
      this.externalLink,
      this.teacher,
      this.subject,
      this.stage,
      this.section,
      this.createdAt});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      externalLink: json['outside_link'],
      isNew: json['is_new'],
      video: json['video'] != null ? Videos.fromJson(json['video']) : null,
      audio: json['audio'] != null ? Audios.fromJson(json['audio']) : null,
      images: json['images'] != null
          ? (json['images'] as List).map((i) => Images.fromJson(i)).toList()
          : null,
      attachments: json['attachments'] != null
          ? (json['attachments'] as List)
              .map((i) => Attachments.fromJson(i))
              .toList()
          : null,
      teacher:
          json['teacher'] != null ? Teacher.fromJson(json['teacher']) : null,
      subject:
          json['subject'] != null ? Subject.fromJson(json['subject']) : null,
      section:
          json['section'] != null ? Section.fromJson(json['section']) : null,
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['outside_link'] = this.externalLink;
    data['description'] = this.description;
    data['is_new'] = this.isNew;
    data['created_at'] = this.createdAt;
    if (this.video != null) {
      data['video'] = this.video!.toJson();
    }
    if (this.audio != null) {
      data['audio'] = this.audio!.toJson();
    }
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
  final LinksX? links;

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

  factory Teacher.fromJson(Map<String, dynamic> json) {
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
      links: json['links'] != null ? LinksX.fromJson(json['links']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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

  factory School.fromJson(Map<String, dynamic> json) {
    return School(
      id: json['id'],
      name: json['name'],
      logo: json['logo'],
      schoolCode: json['school_code'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['school_code'] = this.schoolCode;
    return data;
  }
}

class Links {
  final Profile? profile;
  final Chat? chat;

  Links({this.profile, this.chat});

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      profile:
          json['profile'] != null ? Profile.fromJson(json['profile']) : null,
      chat: json['chat'] != null ? Chat.fromJson(json['chat']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      url: json['url'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['type'] = this.type;
    return data;
  }
}

class Chat {
  final String? url;
  final String? type;

  Chat({this.url, this.type});

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      url: json['url'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['type'] = this.type;
    return data;
  }
}

class Subject {
  final int? id;
  final String? name;
  final String? avatar;
  final int? newlyLessonsCount;

  Subject({this.id, this.name, this.avatar, this.newlyLessonsCount});

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
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

class Section {
  final int? id;
  final String? name;

  Section({this.id, this.name});

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
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

class Stage {
  final int? id;
  final String? name;

  Stage({this.id, this.name});

  factory Stage.fromJson(Map<String, dynamic> json) {
    return Stage(
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


class Videos extends Video {
  final int? id;
  final String url;
  final String name;
  final String? type;
  final int? size;
  final String? collection;
  final Details? details;
  final Links? links;

  Videos(
      {this.id,
      required this.url,
      required this.name,
      this.type,
      this.size,
      this.collection,
      this.details,
      this.links})
      : super(thumb: details!.thumb!, url: url, name: name);

  factory Videos.fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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

class Audios extends Audio {
  final int? id;
  final String url;
  final String name;
  final String? type;
  final int? size;
  final String? collection;
  final Details? details;
  final Links? links;

  Audios(
      {this.id,
      required this.url,
      required this.name,
      this.type,
      this.size,
      this.collection,
      this.details,
      this.links})
      : super(name: name, url: url);

  factory Audios.fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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

class Images extends ImageD {
  final int? id;
  final String url;
  final String name;
  final String? type;
  final int? size;
  final String? collection;
  final Details? details;
  final Links? links;

  Images(
      {this.id,
      required this.url,
      required this.name,
      this.type,
      this.size,
      this.collection,
      this.details,
      this.links})
      : super(url: url, name: name);

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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

class Attachments extends Attach {
  final int? id;
  final String url;
  final String name;
  final String? type;
  final int? size;
  final String? collection;
  final Details? details;
  final Links? links;

  Attachments(
      {this.id,
      required this.url,
      required this.name,
      this.type,
      this.size,
      this.collection,
      this.details,
      this.links})
      : super(url: url, name: name);

  factory Attachments.fromJson(Map<String, dynamic> json) {
    return Attachments(
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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

class LinksX {
  final Delete? delete;

  LinksX({this.delete});

  factory LinksX.fromJson(Map<String, dynamic> json) {
    return LinksX(
      delete: json['delete'] != null ? Delete.fromJson(json['delete']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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

  factory Delete.fromJson(Map<String, dynamic> json) {
    return Delete(
      href: json['href'],
      method: json['method'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    data['method'] = this.method;
    return data;
  }
}

class Details {
  final String? thumb;

  Details({this.thumb});

  factory Details.fromJson(Map<String, dynamic> json) {
    return Details(
      thumb: json['thumb'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['thumb'] = this.thumb;
    return data;
  }
}
