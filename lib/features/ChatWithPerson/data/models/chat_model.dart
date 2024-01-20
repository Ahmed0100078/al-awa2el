import 'package:madaresco/features/ChatWithPerson/domain/entities/chat_entity.dart';

// ignore: must_be_immutable
class ChatModel extends ChatEntity {
  final List<ChatData>? data;
  final Links? links;
  final Meta? meta;
  final Room? room;

  ChatModel({this.data, this.links, this.meta, this.room})
      : super(roomId: room!.roomId!, message: data!, next: links!.next ?? "");

  factory ChatModel.fromJson(Map<String?, dynamic> json) {
    return ChatModel(
      data: json['data'] != null
          ? (json['data'] as List).map((i) => ChatData.fromJson(i)).toList()
          : null,
      links: json['links'] != null ? Links.fromJson(json['links']) : null,
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
      room: json['room'] != null ? Room.fromJson(json['room']) : null,
    );
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.links != null) {
      data['links'] = this.links!.toJson();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    if (this.room != null) {
      data['room'] = this.room!.toJson();
    }
    return data;
  }
}

class Links {
  final String? first;
  final String? last;
  final String? prev;
  final String? next;

  Links({this.first, this.last, this.prev, this.next});

  factory Links.fromJson(Map<String?, dynamic> json) {
    return Links(
      first: json['first'],
      last: json['last'] != null ? json['last'] : null,
      prev: json['prev'] != null ? json['prev'] : null,
      next: json['next'] != null ? json['next'] : null,
    );
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['first'] = this.first;
    data['next'] = this.next;
    if (this.last != null) {
      data['last'] = this.last;
    }
    if (this.prev != null) {
      data['prev'] = this.prev;
    }
    return data;
  }
}

class ChatData extends MessageEntity {
  final int? id;
  final Sender? sender;
  final String message;
  final bool? isSeen;
  // final String? createdAtFormated;
  final LinksX? links;
  final String? date;

  ChatData({
    this.id,
    this.sender,
    required this.message,
    this.isSeen,
    super.createdAt,
    super.createdAtFormatted,
    this.links,
    this.date,
  }) : super(message: message, image: sender!.avatar!, senderId: sender.id!);

  factory ChatData.fromJson(Map<String?, dynamic> json) {
    return ChatData(
      id: json['id'],
      sender: json['sender'] != null ? Sender.fromJson(json['sender']) : null,
      message: json['message'],
      isSeen: json['is_seen'],
      createdAt: json['created_at'],
      createdAtFormatted: json['created_at_formated'],
      links: json['links'] != null ? LinksX.fromJson(json['links']) : null,
      date: json['date'] != null ? json['date'] : null,
    );
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['id'] = this.id;
    data['message'] = this.message;
    data['is_seen'] = this.isSeen;
    data['created_at'] = this.createdAt;
    data['created_at_formated'] = this.createdAtFormatted;
    if (this.sender != null) {
      data['sender'] = this.sender!.toJson();
    }
    if (this.links != null) {
      data['links'] = this.links!.toJson();
    }
    if (this.date != null) {
      data['date'] = this.date;
    }
    return data;
  }
}

class Sender {
  final int? id;
  final String? name;
  final String? type;
  final bool? isConnected;
  final dynamic connectedAt;
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

class Meta {
  final int? currentPage;
  final int? from;
  final String? path;
  final int? perPage;
  final int? to;

  Meta({this.currentPage, this.from, this.path, this.perPage, this.to});

  factory Meta.fromJson(Map<String?, dynamic> json) {
    return Meta(
      currentPage: json['current_page'],
      from: json['from'],
      path: json['path'],
      perPage: json['per_page'],
      to: json['to'],
    );
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['current_page'] = this.currentPage;
    data['from'] = this.from;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['to'] = this.to;
    return data;
  }
}

class Room {
  final int? roomId;
  final String? name;
  final String? avatar;
  final String? type;
  final List<Subscriber>? subscribers;
  final LastConversation? lastConversation;
  final int? countUnseen;
  final bool? canJoin;
  final LinksX? links;

  Room(
      {this.roomId,
      this.name,
      this.avatar,
      this.type,
      this.subscribers,
      this.lastConversation,
      this.countUnseen,
      this.canJoin,
      this.links});

  factory Room.fromJson(Map<String?, dynamic> json) {
    return Room(
      roomId: json['room_id'],
      name: json['name'],
      avatar: json['avatar'],
      type: json['type'],
      subscribers: json['subscribers'] != null
          ? (json['subscribers'] as List)
              .map((i) => Subscriber.fromJson(i))
              .toList()
          : null,
      lastConversation: json['lastConversation'] != null
          ? LastConversation.fromJson(json['lastConversation'])
          : null,
      countUnseen: json['count_unseen'],
      canJoin: json['can_join'],
      links: json['links'] != null ? LinksX.fromJson(json['links']) : null,
    );
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['room_id'] = this.roomId;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['type'] = this.type;
    data['count_unseen'] = this.countUnseen;
    data['can_join'] = this.canJoin;
    if (this.subscribers != null) {
      data['subscribers'] = this.subscribers!.map((v) => v.toJson()).toList();
    }
    if (this.lastConversation != null) {
      data['lastConversation'] = this.lastConversation!.toJson();
    }
    if (this.links != null) {
      data['links'] = this.links!.toJson();
    }
    return data;
  }
}

class Subscriber {
  final int? id;
  final String? name;
  final String? avatar;
  final bool? isConnected;
  final String? connectedAt;
  final LastSeen? lastSeen;

  Subscriber(
      {this.id,
      this.name,
      this.avatar,
      this.isConnected,
      this.connectedAt,
      this.lastSeen});

  factory Subscriber.fromJson(Map<String?, dynamic> json) {
    return Subscriber(
      id: json['id'],
      name: json['name'],
      avatar: json['avatar'],
      isConnected: json['is_connected'],
      connectedAt: json['connected_at'],
      lastSeen: json['last_seen'] != null
          ? LastSeen.fromJson(json['last_seen'])
          : null,
    );
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['is_connected'] = this.isConnected;
    data['connected_at'] = this.connectedAt;
    if (this.lastSeen != null) {
      data['last_seen'] = this.lastSeen!.toJson();
    }
    return data;
  }
}

class LastSeen {
  final int? conversationId;
  final String? seenAt;
  final String? seenAtFormated;

  LastSeen({this.conversationId, this.seenAt, this.seenAtFormated});

  factory LastSeen.fromJson(Map<String?, dynamic> json) {
    return LastSeen(
      conversationId: json['conversation_id'],
      seenAt: json['seen_at'] != null ? json['seen_at'] : null,
      seenAtFormated:
          json['seen_at_formated'] != null ? json['seen_at_formated'] : null,
    );
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['conversation_id'] = this.conversationId;
    if (this.seenAt != null) {
      data['seen_at'] = this.seenAt;
    }
    if (this.seenAtFormated != null) {
      data['seen_at_formated'] = this.seenAtFormated;
    }
    return data;
  }
}

class LastConversation {
  final int? id;
  final Sender? sender;
  final String? message;
  final bool? isSeen;
  final String? date;
  final String? createdAt;
  final String? createdAtFormated;
  final LinksX? links;

  LastConversation(
      {this.id,
      this.sender,
      this.message,
      this.isSeen,
      this.date,
      this.createdAt,
      this.createdAtFormated,
      this.links});

  factory LastConversation.fromJson(Map<String?, dynamic> json) {
    return LastConversation(
      id: json['id'],
      sender: json['sender'] != null ? Sender.fromJson(json['sender']) : null,
      message: json['message'],
      isSeen: json['is_seen'],
      date: json['date'] != null ? json['date'] : null,
      createdAt: json['created_at'],
      createdAtFormated: json['created_at_formated'],
      links: json['links'] != null ? LinksX.fromJson(json['links']) : null,
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
      data['date'] = this.date;
    }
    if (this.links != null) {
      data['links'] = this.links!.toJson();
    }
    return data;
  }
}

class LinksX {
  final SendMessage? sendMessage;
  final Conversation? conversation;

  LinksX({this.sendMessage, this.conversation});

  factory LinksX.fromJson(Map<String?, dynamic> json) {
    return LinksX(
      sendMessage: json['send_message'] != null
          ? SendMessage.fromJson(json['send_message'])
          : null,
      conversation: json['conversation'] != null
          ? Conversation.fromJson(json['conversation'])
          : null,
    );
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    if (this.sendMessage != null) {
      data['send_message'] = this.sendMessage!.toJson();
    }
    if (this.conversation != null) {
      data['conversation'] = this.conversation!.toJson();
    }
    return data;
  }
}

class Conversation {
  final String? url;
  final String? type;

  Conversation({this.url, this.type});

  factory Conversation.fromJson(Map<String?, dynamic> json) {
    return Conversation(
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

class SendMessage {
  final String? url;
  final String? type;

  SendMessage({this.url, this.type});

  factory SendMessage.fromJson(Map<String?, dynamic> json) {
    return SendMessage(
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
