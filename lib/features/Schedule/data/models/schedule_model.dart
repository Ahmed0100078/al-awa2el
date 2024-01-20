import 'package:logging/logging.dart';
import 'package:madaresco/features/Schedule/domain/entities/schedule_entity.dart';

class ScheduleModel extends ScheduleEntity {
  final List<Data>? data;

  ScheduleModel({this.data}) : super(schedules: data!);

  factory ScheduleModel.fromJson(Map<String?, dynamic> json) {
    return ScheduleModel(
      data: json['data'] != null && json['data'] != []
          ? (json['data'] as List).map((i) => Data.fromJson(i)).toList()
          : null,
    );
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data extends ScheduleSubject {
  final String? day;
  final Subject? subject;
  final Section? section;
  final Teacher? teacher;
  final int? sort;
  final String? localedSort;
  final String? startAt;
  final String? endAt;
  final String? timeFormated;

  Data(
      {this.day,
      this.subject,
      this.section,
      this.teacher,
      this.sort,
      this.localedSort,
      this.startAt,
      this.endAt,
      this.timeFormated})
      : super(
            subjectn: subject!.name!,
            teachern: teacher!.name!,
            classroom:section!.grade!.name! ,
            division: section.name!,
            duration:
                getDurationFromDate(startAt ?? "", endAt ?? "") ?? "",
            time: timeFormated ?? "");

  factory Data.fromJson(Map<String?, dynamic> json) {
    return Data(
      day: json['day'],
      subject:
          json['subject'] != null ? Subject.fromJson(json['subject']) : null,
      section:
          json['section'] != null ? Section.fromJson(json['section']) : null,
      teacher:
          json['teacher'] != null ? Teacher.fromJson(json['teacher']) : null,
      sort: json['sort'],
      localedSort: json['localed_sort'],
      startAt: json['start_at'] != null ? json['start_at'] : null,
      endAt: json['end_at'] != null ? json['end_at'] : null,
      timeFormated:
          json['time_formated'] != null ? json['time_formated'] : null,
    );
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['day'] = this.day;
    data['sort'] = this.sort;
    data['localed_sort'] = this.localedSort;
    if (this.subject != null) {
      data['subject'] = this.subject!.toJson();
    }
    if (this.section != null) {
      data['section'] = this.section!.toJson();
    }
    if (this.teacher != null) {
      data['teacher'] = this.teacher!.toJson();
    }
    if (this.startAt != null) {
      data['start_at'] = this.startAt;
    }
    if (this.endAt != null) {
      data['end_at'] = this.endAt;
    }
    if (this.timeFormated != null) {
      data['time_formated'] = this.timeFormated;
    }
    return data;
  }

  static String? getDurationFromDate(String? from, String? to) {
    final Logger _logger = Logger('ScheduleModel');
    try {
      DateTime nowd = DateTime.parse('0000-00-00 ' + to!);
      _logger.info(nowd.toIso8601String);
      DateTime date2 = DateTime.parse('0000-00-00 ' + from!);
      final difference = nowd.difference(date2).inHours;
      _logger.info(difference);
      return difference.toString();
    } catch (e) {
      _logger.severe(e);
      return null;
    }
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

class Links {
  final Profile? profile;
  final Chat? chat;

  Links({this.profile, this.chat});

  factory Links.fromJson(Map<String?, dynamic> json) {
    return Links(
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
  final Grade? grade;

  Section({this.id, this.name, this.grade});

  factory Section.fromJson(Map<String?, dynamic> json) {
    return Section(
      id: json['id'],
      name: json['name'],
      grade: json['grade'] != null ? Grade.fromJson(json['grade']) : null,
    );
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.grade != null) {
      data['grade'] = this.grade!.toJson();
    }
    return data;
  }
}

class Grade {
  final int? id;
  final String? name;
  final Stage? stage;

  Grade({this.id, this.name, this.stage});

  factory Grade.fromJson(Map<String?, dynamic> json) {
    return Grade(
      id: json['id'],
      name: json['name'],
      stage: json['stage'] != null ? Stage.fromJson(json['stage']) : null,
    );
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.stage != null) {
      data['stage'] = this.stage!.toJson();
    }
    return data;
  }
}

class Stage {
  final int? id;
  final String? name;

  Stage({this.id, this.name});

  factory Stage.fromJson(Map<String?, dynamic> json) {
    return Stage(
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
