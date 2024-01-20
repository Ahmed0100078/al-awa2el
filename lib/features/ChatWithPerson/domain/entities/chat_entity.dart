import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class ChatEntity extends Equatable {
  final List<MessageEntity>? message;
  String? next;
  final int? roomId;

  ChatEntity({required this.message, required this.next, required this.roomId});

  @override
  List<Object> get props => [message!, next!];

  ChatEntity copy() => _copy(this);

  ChatEntity copyWithProperties(
          {List<MessageEntity>? message, String? next, int? roomId}) =>
      _copy(this, message: message!, next: next ?? "", roomId: roomId);

  static ChatEntity _copy(ChatEntity master,
      {List<MessageEntity>? message, String? next, int? roomId}) {
    return ChatEntity(
        message: message ?? master.message,
        next: next ?? master.next,
        roomId: roomId ?? master.roomId);
  }

  ChatEntity copyWithMaster(ChatEntity master) {
    return _copy(master);
  }

  ChatEntity copyWith() {
    return _copy(this);
  }
}

class MessageEntity extends Equatable {
  final String image, message;
  final int senderId;
  final String? createdAt;
  final String? createdAtFormatted;

  const MessageEntity(
      {required this.image,
      required this.createdAt,
      this.createdAtFormatted,
      required this.message,
      required this.senderId});

  @override
  List<Object> get props => [image, message, senderId];
}
