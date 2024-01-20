import 'package:equatable/equatable.dart';

class NotEntity extends Equatable {
  final String adminWordCount,
      attendanceCount,
      lessonsCount,
      newsCount,
      installmentCount,
      warningCount,
      schoolMediaCount,
      schedulesCount,
      resultCount,
      examsCount,
      unseenRoomsCount,
      unseenAdminstrationConversationsCount;

  @override
  List<Object> get props => [
        adminWordCount,
        attendanceCount,
        lessonsCount,
        newsCount,
        installmentCount,
        warningCount,
        schoolMediaCount,
        schedulesCount,
        resultCount,
        examsCount,
        unseenRoomsCount,
        unseenAdminstrationConversationsCount
      ];

  const NotEntity({
    required this.adminWordCount,
    required this.attendanceCount,
    required this.lessonsCount,
    required this.newsCount,
    required this.installmentCount,
    required this.warningCount,
    required this.schoolMediaCount,
    required this.schedulesCount,
    required this.resultCount,
    required this.examsCount,
    required this.unseenRoomsCount,
    required this.unseenAdminstrationConversationsCount,
  });
}
