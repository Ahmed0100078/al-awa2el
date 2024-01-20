import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:multi_image_picker_plus/multi_image_picker_plus.dart';

class UploadLessonEntity extends Equatable {
  final String? name, description, externalLink;
  final int? subjectId, sectionId;
  final File? video, audio;
  final List<File>? attachments;
  final List<Asset>? images;

  const UploadLessonEntity({
    required this.name,
    required this.description,
    required this.subjectId,
    required this.sectionId,
    this.video,
    this.audio,
    this.externalLink,
    this.attachments,
    this.images,
  });

  @override
  List<Object> get props => [name!, description!, subjectId!, sectionId!];
}
