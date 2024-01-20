import 'package:madaresco/features/Supervisor/domain/entities/supervisor_entity.dart';

class SupervisorModel extends SupervisorEntity {
  SupervisorModel({
    this.data,
    this.token,
  }) : super(name: '',avatar: '',school: '',subject: '',);

  final Data ?data;
  final String ?token;

  factory SupervisorModel.fromJson(Map<String, dynamic> json) =>
      SupervisorModel(
        data: Data.fromJson(json["data"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
        "token": token,
      };
}

class Data {
  Data({
    this.id,
    this.name,
    this.avatar,
    this.email,
    this.mobile,
    this.type,
    this.isActive,
    this.isConnected,
    this.students,
  });

  int ? id;
  String ?name;
  String ?avatar;
  String ?email;
  String ?mobile;
  String ?type;
  bool ? isActive;
  bool ? isConnected;
  List<Student> ?students;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        avatar: json["avatar"],
        email: json["email"],
        mobile: json["mobile"],
        type: json["type"],
        isActive: json["is_active"],
        isConnected: json["is_connected"],
        students: List<Student>.from(
            json["students"].map((x) => Student.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "avatar": avatar,
        "email": email,
        "mobile": mobile,
        "type": type,
        "is_active": isActive,
        "is_connected": isConnected,
        "students": List<dynamic>.from(students!.map((x) => x.toJson())),
      };
}

class Student {
  Student({
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
    this.school,
    this.location,
    this.warnings,
  });

  int ? id;
  String ?name;
  String ?email;
  String ?mobile;
  String ?avatar;
  Section ?section;
  int ? rateStudent;
  String ?preferenceStudent;
  String ?about;
  String ?type;
  bool ? isConnected;
  bool ? isActive;
  School ?school;
  Location ?location;
  List<dynamic>? warnings;

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        id: json["id"],
        name: json["name"],
        email: json["email"] == null ? null : json["email"],
        mobile: json["mobile"] == null ? null : json["mobile"],
        avatar: json["avatar"],
        section: Section.fromJson(json["section"]),
        rateStudent: json["rate_student"] == null ? null : json["rate_student"],
        preferenceStudent: json["preference_student"] == null
            ? null
            : json["preference_student"],
        about: json["about"] == null ? null : json["about"],
        type: json["type"],
        isConnected: json["is_connected"],
        isActive: json["is_active"],
        school: School.fromJson(json["school"]),
        location: Location.fromJson(json["location"]),
        warnings: List<dynamic>.from(json["warnings"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email == null ? null : email,
        "mobile": mobile == null ? null : mobile,
        "avatar": avatar,
        "section": section!.toJson(),
        "rate_student": rateStudent == null ? null : rateStudent,
        "preference_student":
            preferenceStudent == null ? null : preferenceStudent,
        "about": about == null ? null : about,
        "type": type,
        "is_connected": isConnected,
        "is_active": isActive,
        "school": school!.toJson(),
        "location": location!.toJson(),
        "warnings": List<dynamic>.from(warnings!.map((x) => x)),
      };
}

class Location {
  Location({
    this.lat,
    this.lng,
  });

  dynamic lat;
  dynamic lng;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"],
        lng: json["lng"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}

class School {
  School({
    this.id,
    this.name,
    this.logo,
    this.schoolCode,
  });

  int ? id;
  String ?name;
  String ?logo;
  String ?schoolCode;

  factory School.fromJson(Map<String, dynamic> json) => School(
        id: json["id"],
        name: json["name"],
        logo: json["logo"],
        schoolCode: json["school_code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "logo": logo,
        "school_code": schoolCode,
      };
}

class Section {
  Section({
    this.id,
    this.name,
    this.grade,
  });

  int ? id;
  String ?name;
  Grade ?grade;

  factory Section.fromJson(Map<String, dynamic> json) => Section(
        id: json["id"],
        name: json["name"],
        grade: Grade.fromJson(json["grade"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "grade": grade!.toJson(),
      };
}

class Grade {
  Grade({
    this.id,
    this.name,
    this.stage,
  });

  int ? id;
  String ?name;
  Stage ?stage;

  factory Grade.fromJson(Map<String, dynamic> json) => Grade(
        id: json["id"],
        name: json["name"],
        stage: Stage.fromJson(json["stage"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "stage": stage!.toJson(),
      };
}

class Stage {
  Stage({
    this.id,
    this.name,
  });

  int ? id;
  String ?name;

  factory Stage.fromJson(Map<String, dynamic> json) => Stage(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
