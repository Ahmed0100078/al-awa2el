import 'package:logging/logging.dart';
import 'package:madaresco/features/ExamSchedule/domain/entities/exam_schedule_entity.dart';

final Logger _logger = Logger('ExamScheduleModel');

class ExamScheduleModel extends ExamScheduleEntity {
  final Data ?data;

  ExamScheduleModel({this.data}) : super(name: data!.name!, examSubjects: data.subjects!);

  factory ExamScheduleModel.fromJson(Map<String, dynamic> json) {
    return ExamScheduleModel(
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
  final int ?id;
  final String ?name;
  final List<Subject> ?subjects;

  Data({this.id, this.name, this.subjects});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      name: json['name'],
      subjects: json['subjects'] != null
          ? (json['subjects'] as List).map((i) => Subject.fromJson(i)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.subjects != null) {
      data['subjects'] = this.subjects!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subject extends ExamSubjects {
  final SubjectX ?subject;
  final String ?date;
  final String ?day;
  final String ?startAt;
  final String ?endAt;
  final String ?timeFormated;

  Subject({this.subject, this.date, this.day, this.startAt, this.endAt, this.timeFormated})
      : super(
            date: day! + ' ' + date!,
            name: subject!.name,
            duration: getDurationFromDate(startAt!, endAt!),
            time: timeFormated);

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      subject: json['subject'] != null ? SubjectX.fromJson(json['subject']) : null,
      date: json['date'],
      day: json['day'],
      startAt: json['start_at'],
      endAt: json['end_at'],
      timeFormated: json['time_formated'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['day'] = this.day;
    data['start_at'] = this.startAt;
    data['end_at'] = this.endAt;
    data['time_formated'] = this.timeFormated;
    if (this.subject != null) {
      data['subject'] = this.subject!.toJson();
    }
    return data;
  }

  static String ?getDurationFromDate(String from, String to) {
    try {
      DateTime nowd = DateTime.parse('0000-00-00 ' + to);
      _logger.info(nowd.toIso8601String());
      DateTime date2 = DateTime.parse('0000-00-00 ' + from);
      final difference = nowd.difference(date2).inHours;
      _logger.info(difference);
      return difference.toString();
    } catch (e) {
      _logger.severe(e);
      return null;
    }
  }
}

class SubjectX {
  final int ?id;
  final String ?name;
  final String ?avatar;
  final int ?newlyLessonsCount;

  SubjectX({this.id, this.name, this.avatar, this.newlyLessonsCount});

  factory SubjectX.fromJson(Map<String, dynamic> json) {
    return SubjectX(
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
