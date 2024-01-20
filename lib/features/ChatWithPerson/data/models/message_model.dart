import 'package:madaresco/features/ChatWithPerson/domain/entities/chat_entity.dart';

class MessageModel extends MessageEntity {
  final ChatData? data;

  MessageModel({this.data})
      : super(
            createdAt: data!.createdAt!,
            message: data.message!,
            image: data.sender!.avatar!,
            senderId: data.sender!.id!);

  factory MessageModel.fromJson(Map<String?, dynamic> json) {
    return MessageModel(
      data: json['data'] != null ? ChatData.fromJson(json['data']) : null,
    );
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ChatData {
  final int? id;
  final Sender? sender;
  final String? message;
  final bool? isSeen;
  final Date? date;
  final String? createdAt;
  final String? createdAtFormated;
  final Links? links;

  ChatData(
      {this.id,
      this.sender,
      this.message,
      this.isSeen,
      this.date,
      this.createdAt,
      this.createdAtFormated,
      this.links});

  factory ChatData.fromJson(Map<String?, dynamic> json) {
    return ChatData(
      id: json['id'],
      sender: json['sender'] != null ? Sender.fromJson(json['sender']) : null,
      message: json['message'],
      isSeen: json['is_seen'],
      date: json['date'] != null ? Date.fromJson(json['date']) : null,
      createdAt: json['created_at'],
      createdAtFormated: json['created_at_formated'],
      links: json['links'] != null ? Links.fromJson(json['links']) : null,
    );
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['id'] = this.id;
    data['message'] = this.message;
    data['is_seen'] = this.isSeen;
    data['created_at'] = this.createdAt;
    data['created_at_formated'] = this.createdAtFormated;
    if (this.sender != null) {
      data['sender'] = this.sender!.toJson();
    }
    if (this.date != null) {
      data['date'] = this.date!.toJson();
    }
    if (this.links != null) {
      data['links'] = this.links!.toJson();
    }
    return data;
  }
}

class Date {
  final String? date;
  final int? timezoneType;
  final String? timezone;

  Date({this.date, this.timezoneType, this.timezone});

  factory Date.fromJson(Map<String?, dynamic> json) {
    return Date(
      date: json['date'],
      timezoneType: json['timezone_type'],
      timezone: json['timezone'],
    );
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['date'] = this.date;
    data['timezone_type'] = this.timezoneType;
    data['timezone'] = this.timezone;
    return data;
  }
}

class Sender {
  final int? id;
  final String? name;
  final String? type;
  final bool? isConnected;
  final String? connectedAt;
  final String? avatar;

  Sender(
      {this.id,
      this.name,
      this.type,
      this.isConnected,
      this.connectedAt,
      this.avatar});

  factory Sender.fromJson(Map<String?, dynamic> json) {
    return Sender(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      isConnected: json['is_connected'],
      connectedAt: json['connected_at'],
      avatar: json['avatar'],
    );
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['is_connected'] = this.isConnected;
    data['connected_at'] = this.connectedAt;
    data['avatar'] = this.avatar;
    return data;
  }
}

class Links {
  final DeleteMessage? deleteMessage;

  Links({this.deleteMessage});

  factory Links.fromJson(Map<String?, dynamic> json) {
    return Links(
      deleteMessage: json['delete_message'] != null
          ? DeleteMessage.fromJson(json['delete_message'])
          : null,
    );
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    if (this.deleteMessage != null) {
      data['delete_message'] = this.deleteMessage!.toJson();
    }
    return data;
  }
}

class DeleteMessage {
  final String? url;
  final String? type;

  DeleteMessage({this.url, this.type});

  factory DeleteMessage.fromJson(Map<String?, dynamic> json) {
    return DeleteMessage(
      url: json['url'],
      type: json['type'],
    );
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['url'] = this.url;
    data['type'] = this.type;
    return data;
  }
}
