import 'package:madaresco/features/ExamResult/domain/entities/exam_result_entity.dart';

class ExamResultsModel extends ExamResultEntity {
  final List<Data>? data;

  ExamResultsModel({this.data}) : super(results: data!);

  factory ExamResultsModel.fromJson(Map<String, dynamic> json) {
    return ExamResultsModel(
      data: json['data'] != null
          ? (json['data'] as List).map((i) => Data.fromJson(i)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data extends ExamEntity {
  final String? exam;
  final List<Result>? results;
  final int total;

  Data({this.exam, this.results, required this.total})
      : super(examName: exam!, total: total, subjects: results!);

  factory Data.fromJson(Map<String, dynamic> json) {
    print(json);
    return Data(
      exam: json['exam'],
      results: json['results'] != null
          ? (json['results'] as List).map((i) => Result.fromJson(i)).toList()
          : null,
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['exam'] = this.exam;
    data['total'] = this.total;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result extends SubjectsEntity {
  final Subject? subject;
  final int? mark;
  final bool succeed;

  Result({
    this.subject,
    this.mark,
    this.succeed = false,
  }) : super(subjectName: subject!.name!, subjectTotal: mark ?? 0, succeed: succeed);

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      subject:
          json['subject'] != null ? Subject.fromJson(json['subject']) : null,
      mark: json['mark'],
      succeed: json['succeed'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subject != null) {
      data['subject'] = this.subject!.toJson();
    }
    if (this.mark != null) {
      data['mark'] = this.mark;
    }
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
