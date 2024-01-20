import 'package:madaresco/features/SchoolNews/domain/entities/school_news_entity.dart';

// ignore: must_be_immutable
class SchoolNewsModel extends SchoolNewsEntity {
  final List<Data>? data;
  final Links? links;
  final Meta? meta;

  SchoolNewsModel({this.data, this.links, this.meta})
      : super(news: data!, next: links!.next ?? "");

  factory SchoolNewsModel.fromJson(Map<String?, dynamic> json) {
    return SchoolNewsModel(
      data: json['data'] != null
          ? (json['data'] as List).map((i) => Data.fromJson(i)).toList()
          : null,
      links: json['links'] != null ? Links.fromJson(json['links']) : null,
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
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
    return data;
  }
}

class Meta {
  final int? currentPage;
  final int? from;
  final int? lastPage;
  final String? path;
  final int? perPage;
  final int? to;
  final int? total;

  Meta(
      {this.currentPage,
      this.from,
      this.lastPage,
      this.path,
      this.perPage,
      this.to,
      this.total});

  factory Meta.fromJson(Map<String?, dynamic> json) {
    return Meta(
      currentPage: json['current_page'],
      from: json['from'],
      lastPage: json['last_page'],
      path: json['path'],
      perPage: json['per_page'],
      to: json['to'],
      total: json['total'],
    );
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['current_page'] = this.currentPage;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class Data extends NewsEntity {
  final int id;
  final String title;
  final String? body;
  final int? isUrgent;
  final int? viewsCount;
  final String? createdAt;
  final String? avatar;
  final List<Album>? album;
  final dynamic ratio;

  Data(
      {required this.id,
      this.title = '',
      this.body,
      this.isUrgent,
      this.viewsCount,
      this.createdAt,
      this.avatar,
      this.album,
      this.ratio})
      : super(
            title: title,
            description: body!,
            number: viewsCount!,
            date: createdAt!,
            image: avatar!,
            id: id,
            photos: album!);

  factory Data.fromJson(Map<String?, dynamic> json) {
    return Data(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      isUrgent: json['is_urgent'],
      viewsCount: json['views_count'],
      createdAt: json['created_at'],
      avatar: json['avatar'],
      album: json['album'] != null
          ? (json['album'] as List).map((i) => Album.fromJson(i)).toList()
          : null,
      ratio: json['ratio'] ?? '0',
    );
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    data['is_urgent'] = this.isUrgent;
    data['views_count'] = this.viewsCount;
    data['created_at'] = this.createdAt;
    data['avatar'] = this.avatar;
    data['ratio'] = this.ratio;
    if (this.album != null) {
      data['album'] = this.album!.map((v) => v.toJson()).toList();
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
      last: json['last'],
      prev: json['prev'] != null ? json['prev'] : null,
      next: json['next'] != null ? json['next'] : null,
    );
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['first'] = this.first;
    data['last'] = this.last;
    if (this.prev != null) {
      data['prev'] = this.prev;
    }
    if (this.next != null) {
      data['next'] = this.next;
    }
    return data;
  }
}

class Album {
  final int? mediaId;
  final String? link;
  final num? ratio;

  Album({this.mediaId, this.link, this.ratio});

  factory Album.fromJson(Map<String?, dynamic> json) {
    return Album(
      mediaId: json['media_id'],
      link: json['link'],
      ratio: json['ratio'],
    );
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['media_id'] = this.mediaId;
    data['link'] = this.link;
    data['ratio'] = this.ratio;
    return data;
  }
}
