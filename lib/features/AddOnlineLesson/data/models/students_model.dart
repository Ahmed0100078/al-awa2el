import 'package:madaresco/features/AddOnlineLesson/domain/entities/students_entity.dart';

class StudentsModel extends StudentsEntity {
  final List<Data> ?data;
  final Links ?links;
  final Meta ?meta;

   StudentsModel({this.data, this.links, this.meta}) : super(students: data!, next: '');

   factory StudentsModel.fromJson(Map<String?, dynamic> json) {
    return StudentsModel(
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
  /*final String? next;*/

  Links({this.first, this.last, this.prev,/* this.next*/});

  factory Links.fromJson(Map<String?, dynamic> json) {
    return Links(
      first: json['first'],
      last: json['last'],
      prev: json['prev'] != null ? json['prev'] : null,
    /*  next: json['next'] != null ? json['next'] : null,*/
    );
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['first'] = this.first;
    data['last'] = this.last;
    if (this.prev != null) {
      data['prev'] = this.prev;
    }
   /* if (this.next != null) {
      data['next'] = this.next;
    }*/
    return data;
  }
}

class Meta {
  final int ? currentPage;
  final int ? from;
  final int ? lastPage;
  final String? path;
  final int ? perPage;
  final int ? to;
  final int ? total;

  Meta(
      {this.currentPage,
      this.from,
      this.lastPage,
      this.path,
      this.perPage,
      this.to,
      this.total});

  factory Meta.fromJson(Map<String?, dynamic> json) {
    return Meta(
      currentPage: json['current_page'],
      from: json['from'],
      lastPage: json['last_page'],
      path: json['path'],
      perPage: json['per_page'],
      to: json['to'],
      total: json['total'],
    );
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['current_page'] = this.currentPage;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

// ignore: must_be_immutable
class Data extends Students {
  final int  id;
  final String name;
  final String? avatar;
  final Section ?section;
  final String? type;
  final bool ? isConnected;
  final bool ? isActive;
  final School ?school;
  final String? email;
  final String? mobile;
  final int ? rateStudent;
  final String? preferenceStudent;
  final String? about;

  Data({
    required this.id,
    required this.name,
    this.avatar,
    this.section,
    this.type,
    this.isConnected,
    this.isActive,
    this.school,
    this.email,
    this.mobile,
    this.rateStudent,
    this.preferenceStudent,
    this.about,
  }) : super(name: name, id: id);

  factory Data.fromJson(Map<String?, dynamic> json) {
    return Data(
      id: json['id'],
      name: json['name'],
      avatar: json['avatar'],
      section: json['section'] != null ? Section.fromJson(json['section']) : null,
      type: json['type'],
      isConnected: json['is_connected'],
      isActive: json['is_active'],
      school: json['school'] != null ? School.fromJson(json['school']) : null,
      email: json['email'] != null ? json['email'] : null,
      mobile: json['mobile'] != null ? json['mobile'] : null,
      rateStudent: json['rate_student'] != null ? json['rate_student'] : null,
      preferenceStudent: json['preference_student'] != null ? json['preference_student'] : null,
      about: json['about'] != null ? json['about'] : null,
    );
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['type'] = this.type;
    data['is_connected'] = this.isConnected;
    data['is_active'] = this.isActive;
    if (this.section != null) {
      data['section'] = this.section!.toJson();
    }
    if (this.school != null) {
      data['school'] = this.school!.toJson();
    }
    if (this.email != null) {
      data['email'] = this.email;
    }
    if (this.mobile != null) {
      data['mobile'] = this.mobile;
    }
    if (this.rateStudent != null) {
      data['rate_student'] = this.rateStudent;
    }
    if (this.preferenceStudent != null) {
      data['preference_student'] = this.preferenceStudent;
    }
    if (this.about != null) {
      data['about'] = this.about;
    }
    return data;
  }
}

class Section {
  final int ? id;
  final String? name;
  final Grade ?grade;

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
  final int ? id;
  final String? name;
  final Stage ?stage;

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
  final int ? id;
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

class School {
  final int ? id;
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
