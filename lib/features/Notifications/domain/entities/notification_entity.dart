import 'package:equatable/equatable.dart';

class NotificationsEntity extends Equatable {
  final List<NotificationEntity> notifications;

  const NotificationsEntity({
    required this.notifications,
  });

  @override
  List<Object> get props => [notifications];
}

class NotificationEntity extends Equatable {
  final String body, author, image, time;
  final String? outSideLink;
  final dynamic view;
  final dynamic dataId;

  const NotificationEntity(
      {required this.body,
      this.outSideLink = "",
      this.view = "",
      required this.author,
      required this.image,
      required this.time,
      this.dataId = 0});

  @override
  List<Object> get props =>
      [body, author, image, time, dataId ?? 0, outSideLink ?? "", view ?? ""];
}
