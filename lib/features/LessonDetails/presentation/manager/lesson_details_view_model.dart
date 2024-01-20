import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:madaresco/Util/Event.dart';
import 'package:madaresco/features/LessonDetails/domain/entities/lesson_details_entity.dart';
import 'package:madaresco/features/LessonDetails/domain/use_cases/get_lessons_details_use_case.dart';
import 'package:madaresco/features/Login/presentation/manager/LoginViewModel.dart';
import 'package:video_player/video_player.dart';

class LessonDetailsViewModel extends ChangeNotifier {
  ValueNotifier<bool> _loading = ValueNotifier(false);

  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<Event<String>> _toast = ValueNotifier(Event(''));

  ValueNotifier<Event<String>> get toast => _toast;

  LessonDetailsEntity _entity = LessonDetailsEntity(
    date: '',
    name: '',
    externalLink: '',
    description: '',
    video: null,
    audio: null,
    images: [],
    attachments: [],
    section: null,
    subject: null,
    stage: null,
  );

  LessonDetailsEntity get entity => _entity;

  GetLessonsDetailsUseCase _lessonsDetailsUseCase;
  VideoPlayerController? _controller;

  VideoPlayerController? get controller => _controller;
  ChewieController? _chewieController;
  ChewieController? get chewieController => _chewieController;

  ValueNotifier<int> _lessonId = ValueNotifier(-1);

  set lessonId(int id) => _lessonId.value = id;

  LessonDetailsViewModel({
    required GetLessonsDetailsUseCase lessonsDetailsUseCase,
  }) : _lessonsDetailsUseCase = lessonsDetailsUseCase {
    _lessonId.addListener(() {
      if (_lessonId.value != -1) {
        getLessonDetails();
      }
    });
  }

  void getLessonDetails() async {
    _loading.value = true;
    final failureOrLessonDetails =
        await _lessonsDetailsUseCase(_lessonId.value);
    failureOrLessonDetails
        .fold((l) => _toast.value = Event(SERVER_FAILURE_MESSAGE), (r) async {
      _entity = r;
      notifyListeners();
      if (r.video != null) {
        _controller = VideoPlayerController.network(r.video!.url)
          ..initialize().then((_) {
            // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
            notifyListeners();
          });
        _chewieController = ChewieController(
          videoPlayerController: _controller!,
          aspectRatio: _controller!.value.aspectRatio,
        );
      }
    });
    _loading.value = false;
  }

  @override
  void dispose() {
    super.dispose();
    if (_entity.video != null) {
      _controller!.dispose();
    }
  }
}
