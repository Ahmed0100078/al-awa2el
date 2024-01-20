import 'package:equatable/equatable.dart';
import 'package:madaresco/features/LessonDetails/data/models/lesson_details_model.dart';

class LessonDetailsEntity extends Equatable {
  final String name, description, date, externalLink;
  final Stage? stage;
  final Section? section;
  final Subject? subject;
  final Video? video;
  final Audio? audio;
  final List<ImageD> images;
  final List<Attach> attachments;

  const LessonDetailsEntity({
    required this.stage,
    required this.section,
    required this.subject,
    required this.name,
    required this.externalLink,
    required this.description,
    required this.video,
    required this.audio,
    required this.date,
    required this.images,
    required this.attachments,
  });

  @override
  List<Object> get props =>
      [date, name, description, video!, images, attachments, externalLink];
}

class Video extends Equatable {
  final String url, name, thumb;

  const Video({
    required this.url,
    required this.name,
    required this.thumb,
  });

  @override
  List<Object> get props => [url, name, thumb];
}

class Audio extends Equatable {
  final String url, name;

  const Audio({
    required this.url,
    required this.name,
  });

  @override
  List<Object> get props => [url, name];
}

class ImageD extends Equatable {
  final String url, name;

  const ImageD({
    required this.url,
    required this.name,
  });

  @override
  List<Object> get props => [url, name];
}

class Attach extends Equatable {
  final String url, name;

  const Attach({
    required this.url,
    required this.name,
  });

  @override
  List<Object> get props => [url, name];
}
