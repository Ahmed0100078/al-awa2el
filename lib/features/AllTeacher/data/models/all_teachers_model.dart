import 'package:madaresco/features/AllTeacher/domain/entities/all_teachers_entity.dart';

// ignore: must_be_immutable
class AllTeachersModel extends AllTeachersEntity {
  final List<Data> ?data;
  final LinksX ?links;
  final Meta ?meta;

  AllTeachersModel({this.data, this.links, this.meta}) : super(next: links!.next??"", teachers: data!);

  factory AllTeachersModel.fromJson(Map<String ?, dynamic> json) {
    return AllTeachersModel(
      data: json['data'] != null
          ? (json['data'] as List).map((i) => Data.fromJson(i)).toList()
          : null,
      links: json['links'] != null ? LinksX.fromJson(json['links']) : null,
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

class Data extends Teachers {
  final int id;
  final String  name;
  final String ? type;
  final String ? avatar;
  final bool ? isConnected;
  final int ? unseenCoversationsCount;
  final School ?school;
  final Links ?links;
  final String ? connectedAt;
  final String ? email;
  final String ? mobile;
  final String ? about;

  Data(
      {required this.id,
      required this.name,
      this.type,
      this.avatar,
      this.isConnected,
      this.unseenCoversationsCount,
      this.school,
      this.links,
      this.connectedAt,
      this.email,
      this.mobile,
      this.about})
      : super(name: name, image: avatar!, id: id);

  factory Data.fromJson(Map<String ?, dynamic> json) {
    return Data(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      avatar: json['avatar'],
      isConnected: json['is_connected'],
      unseenCoversationsCount: json['unseen_coversations_count'],
      school: json['school'] != null ? School.fromJson(json['school']) : null,
      links: json['links'] != null ? Links.fromJson(json['links']) : null,
      connectedAt: json['connected_at'],
      email: json['email'] != null ? json['email'] : null,
      mobile: json['mobile'] != null ? json['mobile'] : null,
      about: json['about'] != null ? json['about'] : null,
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
    data['connected_at'] = this.connectedAt;
    if (this.school != null) {
      data['school'] = this.school!.toJson();
    }
    if (this.links != null) {
      data['links'] = this.links!.toJson();
    }
    if (this.email != null) {
      data['email'] = this.email;
    }
    if (this.mobile != null) {
      data['mobile'] = this.mobile;
    }
    if (this.about != null) {
      data['about'] = this.about;
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

class Links {
  final Profile ?profile;
  final Chat ?chat;

  Links({this.profile, this.chat});

  factory Links.fromJson(Map<String ?, dynamic> json) {
    return Links(
      profile: json['profile'] != null ? Profile.fromJson(json['profile']) : null,
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

class LinksX {
  final String ? first;
  final String ? last;
  final String ? prev;
  final String ? next;

  LinksX({this.first, this.last, this.prev, this.next});

  factory LinksX.fromJson(Map<String ?, dynamic> json) {
    return LinksX(
      first: json['first'],
      last: json['last'],
      prev: json['prev'] != null ? json['prev'] : null,
      next: json['next'] != null ? json['next'] : null,
    );
  }

  Map<String ?, dynamic> toJson() {
    final Map<String ?, dynamic> data = new Map<String ?, dynamic>();
    data['first'] = this.first;
    data['last'] = this.last;
    if (this.prev != null) {
      data['prev'] = this.prev;
    }
    if (this.next != null) {
      data['next'] = this.next;
    }
    return data;
  }
}

class Meta {
  final int ? currentPage;
  final int ? from;
  final int ? lastPage;
  final String ? path;
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

  factory Meta.fromJson(Map<String ?, dynamic> json) {
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

  Map<String ?, dynamic> toJson() {
    final Map<String ?, dynamic> data = new Map<String ?, dynamic>();
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
