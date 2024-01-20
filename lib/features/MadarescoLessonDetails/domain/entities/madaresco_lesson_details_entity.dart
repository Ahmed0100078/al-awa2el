import 'package:equatable/equatable.dart';

class MadarescoLessonDetailsEntity extends Equatable {
  final String lessonTitle, lessonDescription, youtubeId;

  const MadarescoLessonDetailsEntity({
    required this.lessonTitle,
    required this.lessonDescription,
    required this.youtubeId,
  });

  @override
  List<Object> get props => [lessonTitle, lessonDescription, youtubeId];
}
