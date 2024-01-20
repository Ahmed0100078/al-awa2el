import 'package:madaresco/features/MyProfile/domain/entities/my_profile_entity.dart';

class MyProfileModel extends MyProfileEntity {
  final Data ?data;
  final String ?token;

  MyProfileModel({this.data, this.token})
      : super(
          name: data!.name??"",
          email: data.email??"",
          phone: data.mobile??"",
          image: data.avatar??"",
        );

  factory MyProfileModel.fromJson(Map<String, dynamic> json) {
    return MyProfileModel(
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  final int ?id;
  final String ?name;
  final String ?email;
  final String ?mobile;
  final String ?avatar;
  final Section? section;
  final String ?about;
  final String ?type;
  final bool ?isConnected;
  final School ?school;
  final List<Warning>? warnings;

  Data(
      {this.id,
      this.name,
      this.email,
      this.mobile,
      this.avatar,
      this.section,
      this.about,
      this.type,
      this.isConnected,
      this.school,
      this.warnings});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      name: json['name'],
      email: json['email'] != null ? json['email'] : null,
      mobile: json['mobile'] != null ? json['mobile'] : null,
      avatar: json['avatar'],
      section: json['section'] != null ? Section.fromJson(json['section']) : null,
      about: json['about'] != null ? json['about'] : null,
      type: json['type'],
      isConnected: json['is_connected'],
      school: json['school'] != null ? School.fromJson(json['school']) : null,
      warnings: json['warnings'] != null
          ? (json['warnings'] as List).map((i) => Warning.fromJson(i)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['type'] = this.type;
    data['is_connected'] = this.isConnected;
    if (this.email != null) {
      data['email'] = this.email;
    }
    if (this.mobile != null) {
      data['mobile'] = this.mobile;
    }
    if (this.section != null) {
      data['section'] = this.section!.toJson();
    }
    if (this.about != null) {
      data['about'] = this.about;
    }
    if (this.school != null) {
      data['school'] = this.school!.toJson();
    }
    if (this.warnings != null) {
      data['warnings'] = this.warnings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class School {
  final int? id;
  final String ?name;
  final String ?logo;
  final String ?schoolCode;

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

class Section {
  final int ?id;
  final String? name;
  final Grade ?grade;

  Section({this.id, this.name, this.grade});

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      id: json['id'],
      name: json['name'],
      grade: json['grade'] != null ? Grade.fromJson(json['grade']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.grade != null) {
      data['grade'] = this.grade!.toJson();
    }
    return data;
  }
}

class Grade {
  final int ?id;
  final String ?name;
  final Stage ?stage;

  Grade({this.id, this.name, this.stage});

  factory Grade.fromJson(Map<String, dynamic> json) {
    return Grade(
      id: json['id'],
      name: json['name'],
      stage: json['stage'] != null ? Stage.fromJson(json['stage']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.stage != null) {
      data['stage'] = this.stage!.toJson();
    }
    return data;
  }
}

class Stage {
  final int ?id;
  final String ?name;

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

class Warning {
  final int ?id;
  final String? reason;
  final String ?date;

  Warning({this.id, this.reason, this.date});

  factory Warning.fromJson(Map<String, dynamic> json) {
    return Warning(
      id: json['id'],
      reason: json['reason'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reason'] = this.reason;
    data['date'] = this.date;
    return data;
  }
}
