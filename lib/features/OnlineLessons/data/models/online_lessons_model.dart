import 'package:madaresco/features/OnlineLessons/data/models/meetingRoom.dart';
import 'package:madaresco/features/OnlineLessons/domain/entities/online_lessons_entity.dart';

// ignore: must_be_immutable
class OnlineLessonsModel extends OnlineLessonsEntity {
  final List<Data> ?data;
  final Links ?links;
  final Meta ?meta;

  OnlineLessonsModel({this.data, this.links, this.meta})
      : super(lessons: data!, next: links!.next??"");

  factory OnlineLessonsModel.fromJson(Map<String ?, dynamic> json) {
    return OnlineLessonsModel(
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

class Data extends OnlineLessons {
  final String ? date;
  final List<Lesson> ?lessons;

  Data({this.date, this.lessons})
      : super(lessonDate: date!, onlineLessons: lessons!);

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

class Lesson extends OnlineLesson {
  final int ? id;
  final String ? name;
  final String ? description;
  final bool ? isNew;
  final Teacher ?teacher;
  final Subject ?subject;
  final Section ?section;
  final String ? createdAt;
  // ignore: non_constant_identifier_names
  final String ? lesson_link;
  final String  channelName;
  final String  token;
  final int  roomId;
  final MeetingRoom meetingRoom;
  final LinksX ?links;

  Lesson(
      {this.id,
      this.name,
      this.description,
      this.isNew,
      this.teacher,
      this.subject,
      this.section,
      this.createdAt,
      // ignore: non_constant_identifier_names
      this.lesson_link,
      required this.channelName,
      required this.token,
      required this.roomId,
      this.links,
      required this.meetingRoom})
      : super(
            lessonLink: lesson_link??"",
            teacherName: teacher!.name!,
            lessonTitle: name!,
            channelName: channelName,
            token: token,
            roomId: roomId,
            lessonId: id!,
            meetingRoom: meetingRoom);

  factory Lesson.fromJson(Map<String ?, dynamic> json) {
    return Lesson(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        isNew: json['is_new'],
        teacher:
            json['teacher'] != null ? Teacher.fromJson(json['teacher']) : null,
        subject:
            json['subject'] != null ? Subject.fromJson(json['subject']) : null,
        section:
            json['section'] != null ? Section.fromJson(json['section']) : null,
        createdAt: json['created_at'],
        lesson_link: json['lesson_link'],
        token: json["token"],
        channelName: json["channel_name"],
        links: json['links'] != null ? LinksX.fromJson(json['links']) : null,
        roomId: json['room_id'],
        meetingRoom: json["room_metting"] == null
            ? MeetingRoom()
          : MeetingRoom.fromJson(json["room_metting"]));
  }

  Map<String ?, dynamic> toJson() {
    final Map<String ?, dynamic> data = new Map<String ?, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['is_new'] = this.isNew;
    data['created_at'] = this.createdAt;
    data['lesson_link'] = this.lesson_link;
    data['token'] = this.token;
    data['channel_name'] = this.channelName;

    if (this.teacher != null) {
      data['teacher'] = this.teacher!.toJson();
    }
    if (this.subject != null) {
      data['subject'] = this.subject!.toJson();
    }
    if (this.section != null) {
      data['section'] = this.section!.toJson();
    }
    if (this.links != null) {
      data['links'] = this.links!.toJson();
    }
    return data;
  }
}

class Section {
  final int ? id;
  final String ? name;

  Section({this.id, this.name});

  factory Section.fromJson(Map<String ?, dynamic> json) {
    return Section(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String ?, dynamic> toJson() {
    final Map<String ?, dynamic> data = new Map<String ?, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class LinksX {
  final Details ?details;

  LinksX({this.details});

  factory LinksX.fromJson(Map<String ?, dynamic> json) {
    return LinksX(
      details:
          json['details'] != null ? Details.fromJson(json['details']) : null,
    );
  }

  Map<String ?, dynamic> toJson() {
    final Map<String ?, dynamic> data = new Map<String ?, dynamic>();
    if (this.details != null) {
      data['details'] = this.details!.toJson();
    }
    return data;
  }
}

class Details {
  final String ? url;
  final String ? type;

  Details({this.url, this.type});

  factory Details.fromJson(Map<String ?, dynamic> json) {
    return Details(
      url: json['url'],
      type: json['type'],
    );
  }

  Map<String ?, dynamic> toJson() {
    final Map<String ?, dynamic> data = new Map<String ?, dynamic>();
    data['url'] = this.url;
    data['type'] = this.type;
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
  final bool ? isActive;
  final int ? unseenCoversationsCount;
  final School ?school;
  final Links ?links;

  Teacher(
      {this.id,
      this.name,
      this.email,
      this.mobile,
      this.type,
      this.about,
      this.avatar,
      this.isConnected,
      this.isActive,
      this.unseenCoversationsCount,
      this.school,
      this.links});

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
      isActive: json['is_active'],
      unseenCoversationsCount: json['unseen_coversations_count'],
      school: json['school'] != null ? School.fromJson(json['school']) : null,
      links: json['links'] != null ? Links.fromJson(json['links']) : null,
    );
  }

  Map<String ?, dynamic> toJson() {
    final Map<String ?, dynamic> data = new Map<String ?, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['avatar'] = this.avatar;
    data['is_connected'] = this.isConnected;
    data['is_active'] = this.isActive;
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

class LinksXX {
  final Profile ?profile;
  final Chat ?chat;

  LinksXX({this.profile, this.chat});

  factory LinksXX.fromJson(Map<String ?, dynamic> json) {
    return LinksXX(
      profile:
          json['profile'] != null ? Profile.fromJson(json['profile']) : null,
      chat: json['chat'] != null ? Chat.fromJson(json['chat']) : null,
    );
  }

  Map<String ?, dynamic> toJson() {
    final Map<String ?, dynamic> data = new Map<String ?, dynamic>();
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    if (this.chat != null) {
      data['chat'] = this.chat!.toJson();
    }
    return data;
  }
}

class Chat {
  final String ? url;
  final String ? type;

  Chat({this.url, this.type});

  factory Chat.fromJson(Map<String ?, dynamic> json) {
    return Chat(
      url: json['url'],
      type: json['type'],
    );
  }

  Map<String ?, dynamic> toJson() {
    final Map<String ?, dynamic> data = new Map<String ?, dynamic>();
    data['url'] = this.url;
    data['type'] = this.type;
    return data;
  }
}

class Profile {
  final String ? url;
  final String ? type;

  Profile({this.url, this.type});

  factory Profile.fromJson(Map<String ?, dynamic> json) {
    return Profile(
      url: json['url'],
      type: json['type'],
    );
  }

  Map<String ?, dynamic> toJson() {
    final Map<String ?, dynamic> data = new Map<String ?, dynamic>();
    data['url'] = this.url;
    data['type'] = this.type;
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
