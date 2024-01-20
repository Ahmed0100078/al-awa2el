import 'package:madaresco/features/Main/domain/entities/NotEntity.dart';

class MainNotificationsModel extends NotEntity {
  final Data ?data;

  MainNotificationsModel({this.data})
      : super(
            adminWordCount: data!.adminWordCount.toString(),
            unseenAdministrationConversationsCount:
                data.unseenAdministrationConversationsCount.toString(),
            unseenRoomsCount: data.unseenRoomsCount.toString(),
            examsCount: data.examsCount.toString(),
            resultCount: data.resultCount.toString(),
            schedulesCount: data.schedulesCount.toString(),
            schoolMediaCount: data.schoolMediaCount.toString(),
            onlineLessonCount: '',
            warningCount: data.warningCount.toString(),
            installmentCount: data.installmentCount.toString(),
            newsCount: data.newsCount.toString(),
            lessonsCount: data.lessonsCount.toString(),
            attendanceCount: data.attendanceCount.toString());

  factory MainNotificationsModel.fromJson(Map<String ?, dynamic> json) {
    return MainNotificationsModel(
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }

  Map<String ?, dynamic> toJson() {
    final Map<String ?, dynamic> data = new Map<String ?, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  final int ? adminWordCount;
  final int ? attendanceCount;
  final int ? lessonsCount;
  final int ? newsCount;
  final int ? installmentCount;
  final int ? warningCount;
  final int ? schoolMediaCount;
  final int ? schedulesCount;
  final int ? resultCount;
  final int ? examsCount;
  final int ? unseenRoomsCount;
  final int ? unseenAdministrationConversationsCount;

  Data(
      {this.adminWordCount,
      this.attendanceCount,
      this.lessonsCount,
      this.newsCount,
      this.installmentCount,
      this.warningCount,
      this.schoolMediaCount,
      this.schedulesCount,
      this.resultCount,
      this.examsCount,
      this.unseenRoomsCount,
      this.unseenAdministrationConversationsCount});

  factory Data.fromJson(Map<String ?, dynamic> json) {
    return Data(
      adminWordCount: json['admin_word_count'],
      attendanceCount: json['attendance_count'],
      lessonsCount: json['lessons_count'],
      newsCount: json['news_count'],
      installmentCount: json['installment_count'],
      warningCount: json['warning_count'],
      schoolMediaCount: json['school_media_count'],
      schedulesCount: json['schedules_count'],
      resultCount: json['result_count'],
      examsCount: json['exams_count'],
      unseenRoomsCount: json['unseen_rooms_count'],
      unseenAdministrationConversationsCount: json['unseen_adminstration_conversations_count'],
    );
  }

  Map<String ?, dynamic> toJson() {
    final Map<String ?, dynamic> data = new Map<String ?, dynamic>();
    data['admin_word_count'] = this.adminWordCount;
    data['attendance_count'] = this.attendanceCount;
    data['lessons_count'] = this.lessonsCount;
    data['news_count'] = this.newsCount;
    data['installment_count'] = this.installmentCount;
    data['warning_count'] = this.warningCount;
    data['school_media_count'] = this.schoolMediaCount;
    data['schedules_count'] = this.schedulesCount;
    data['result_count'] = this.resultCount;
    data['exams_count'] = this.examsCount;
    data['unseen_rooms_count'] = this.unseenRoomsCount;
    data['unseen_adminstration_conversations_count'] =
        this.unseenAdministrationConversationsCount;
    return data;
  }
}
