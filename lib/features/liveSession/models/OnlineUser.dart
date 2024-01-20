class OnlineUsers {
  OnlineUsers({
    this.data,
  });

  List<Datum>? data;

  factory OnlineUsers.fromJson(Map<String ?, dynamic> json) => OnlineUsers(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.avatar,
    this.section,
    this.rateStudent,
    this.preferenceStudent,
    this.about,
    this.type,
    this.isConnected,
    this.isActive,
    this.connectedAt,
    this.school,
    this.location,
    this.warnings,
  });

  int ? id;
  String ? name;
  String ? email;
  String ? mobile;
  String ? avatar;
  Section ?section;
  dynamic rateStudent;
  dynamic preferenceStudent;
  String ? about;
  String ? type;
  bool ?isConnected;
  bool ?isActive;
  String ? connectedAt;
  School ?school;
  Location ?location;
  List<dynamic> ?warnings;

  factory Datum.fromJson(Map<String ?, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        mobile: json["mobile"] == null ? null : json["mobile"],
        avatar: json["avatar"],
        section: Section.fromJson(json["section"]),
        rateStudent: json["rate_student"],
        preferenceStudent: json["preference_student"],
        about: json["about"],
        type: json["type"],
        isConnected: json["is_connected"],
        isActive: json["is_active"],
        connectedAt: json["connected_at"] == null ? null : json["connected_at"],
        school: School.fromJson(json["school"]),
        location: Location.fromJson(json["location"]),
        warnings: List<dynamic>.from(json["warnings"].map((x) => x)),
      );
}

class Location {
  Location({
    this.lat,
    this.lng,
  });

  dynamic lat;
  dynamic lng;

  factory Location.fromJson(Map<String ?, dynamic> json) => Location(
        lat: json["lat"],
        lng: json["lng"],
      );
}

class School {
  School({
    this.id,
    this.name,
    this.logo,
    this.schoolCode,
  });

  int ? id;
  String ? name;
  String ? logo;
  String ? schoolCode;

  factory School.fromJson(Map<String ?, dynamic> json) => School(
        id: json["id"],
        name: json["name"],
        logo: json["logo"],
        schoolCode: json["school_code"],
      );
}

class Section {
  Section({
    this.id,
    this.name,
    this.grade,
  });

  int ? id;
  String ? name;
  Grade ?grade;

  factory Section.fromJson(Map<String ?, dynamic> json) => Section(
        id: json["id"],
        name: json["name"],
        grade: Grade.fromJson(json["grade"]),
      );
}

class Grade {
  Grade({
    this.id,
    this.name,
    this.stage,
  });

  int ? id;
  String ? name;
  Stage ?stage;

  factory Grade.fromJson(Map<String ?, dynamic> json) => Grade(
        id: json["id"],
        name: json["name"],
        stage: Stage.fromJson(json["stage"]),
      );
}

class Stage {
  Stage({
    this.id,
    this.name,
  });

  int ? id;
  String ? name;

  factory Stage.fromJson(Map<String ?, dynamic> json) => Stage(
        id: json["id"],
        name: json["name"],
      );
}
