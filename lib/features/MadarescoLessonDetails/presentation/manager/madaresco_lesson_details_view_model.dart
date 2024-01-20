import 'package:flutter/material.dart';
import 'package:madaresco/Util/Event.dart';
import 'package:madaresco/features/Login/presentation/manager/LoginViewModel.dart';
import 'package:madaresco/features/MadarescoLessonDetails/domain/entities/madaresco_lesson_details_entity.dart';
import 'package:madaresco/features/MadarescoLessonDetails/domain/use_cases/get_madaresco_lesson_details_use_case.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MadarescoLessonDetailsViewModel extends ChangeNotifier {
  ValueNotifier<bool> _loading = ValueNotifier(false);

  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<Event<String>> _toast = ValueNotifier(Event(''));

  ValueNotifier<Event<String>> get toast => _toast;
  MadarescoLessonDetailsEntity _entity = MadarescoLessonDetailsEntity(
      lessonTitle: '', lessonDescription: '', youtubeId: '');

  MadarescoLessonDetailsEntity get entity => _entity;
  ValueNotifier<int> _id = ValueNotifier(-1);

  set id(int i) => _id.value = i;
  GetMadarescoLessonDetailsUseCase _madarescoLessonDetailsUseCase;
  YoutubePlayerController? _controller;
  YoutubePlayerController ?get controller => _controller;

  MadarescoLessonDetailsViewModel({
    required GetMadarescoLessonDetailsUseCase madarescoLessonDetailsUseCase,
  }) : _madarescoLessonDetailsUseCase = madarescoLessonDetailsUseCase {
    _id.addListener(() {
      getLessonDetails();
    });
  }

  void getLessonDetails() async {
    _loading.value = true;
    final failureOrLessonDetails =
        await _madarescoLessonDetailsUseCase(_id.value);
    failureOrLessonDetails
        .fold((l) => _toast.value = Event(SERVER_FAILURE_MESSAGE), (r) {
      _entity = r;
      _controller = YoutubePlayerController(
        initialVideoId: r.youtubeId,
        flags: YoutubePlayerFlags(
          autoPlay: false,
        ),
      );
      notifyListeners();
    });
    _loading.value = false;
  }
}
