import 'package:madaresco/features/MainTeacher/domain/entities/main_teacher_entity.dart';

class TeacherModel extends MainTeacherEntity {
  final Data ?data;
  final String ?token;

  TeacherModel({this.data, this.token})
      : super(
          name: data!.name!,
          avatar: data.avatar!,
          school: data.school!.name!,
          subject: data.type!,
        );

  factory TeacherModel.fromJson(Map<String, dynamic> json) {
    return TeacherModel(
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
  final String ?type;
  final String ?about;
  final String ?avatar;
  final bool ?isConnected;
  final int ?unseenCoversationsCount;
  final School ?school;
  final Links ?links;

  Data(
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

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
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
  final int ?id;
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

class Links {
  final Profile ?profile;
  final Chat ?chat;

  Links({this.profile, this.chat});

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      profile: json['profile'] != null ? Profile.fromJson(json['profile']) : null,
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
  final String ?url;
  final String ?type;

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
  final String ?url;
  final String ?type;

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
