import 'package:flutter/material.dart';
import 'package:madaresco/Util/Event.dart';
import 'package:madaresco/features/Main/domain/entities/NotEntity.dart';

const kAccentColor = Color(0xFF001068);
const kBoxDecoration = BoxDecoration(
    gradient: LinearGradient(
  begin: Alignment.topRight,
  colors: [
    Color(0xFF001068),
    Color(0xFF001068),
  ],
));
ValueNotifier<Locale> locale = ValueNotifier(Locale('en', 'US'));
ValueNotifier<Event<bool>> getNotifications = ValueNotifier(Event(false));
ValueNotifier<NotEntity> notEntity = ValueNotifier(
  NotEntity(
      adminWordCount: '0',
      attendanceCount: '0',
      lessonsCount: '0',
      newsCount: '0',
      installmentCount: '0',
      warningCount: '0',
      schoolMediaCount: '0',
      schedulesCount: '0',
      resultCount: '0',
      examsCount: '0',
      unseenRoomsCount: '0',
      unseenAdministrationConversationsCount: '0',
      onlineLessonCount: '0'),
);

/// TODO: Pass it through environment vars
const String API_KEY = 'AIzaSyBhmRVTxJXbEExsvIKzNTk8bGhu5Ojages';
