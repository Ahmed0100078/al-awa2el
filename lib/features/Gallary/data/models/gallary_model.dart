import 'package:madaresco/features/Gallary/domain/entities/gallary_entity.dart';

// ignore: must_be_immutable
class GallaryModel extends GallaryEntity {
  final List<Data> ?data;
  final LinksX ?links;
  final Meta ?meta;

  GallaryModel({this.data, this.links, this.meta}) : super(gallarys: data!, next: links!.next??'');

  factory GallaryModel.fromJson(Map<String ?, dynamic> json) {
    return GallaryModel(
      data: json['data'] != null
          ? (json['data'] as List).map((i) => Data.fromJson(i)).toList()
          : null,
      links: json['links'] != null ? LinksX.fromJson(json['links']) : null,
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
    );
  }

  Map<String ?, dynamic> toJson() {
    final Map<String ?, dynamic> data = new Map<String ?, dynamic>();
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

class Data extends ItemEntity {
  final int  id;
  final String  name;
  final String  avatar;
  final List<Album>? album;
  final double ? ratio;
  final String ? createdAt;

  Data({required this.id, required this.name, required this.avatar, required this.album, this.ratio, this.createdAt})
      : super(id: id, avatar: avatar, name: name);

  factory Data.fromJson(Map<String ?, dynamic> json) {
    return Data(
      id: json['id'],
      name: json['name'],
      avatar: json['avatar'],
      album: json['album'] != null
          ? (json['album'] as List).map((i) => Album.fromJson(i)).toList()
          : null,
      ratio: double.parse(json['ratio'].toString()),
      createdAt: json['created_at'],
    );
  }

  Map<String ?, dynamic> toJson() {
    final Map<String ?, dynamic> data = new Map<String ?, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['ratio'] = this.ratio;
    data['created_at'] = this.createdAt;
    if (this.album != null) {
      data['album'] = this.album!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Album {
  final int ? id;
  final String ? url;
  final String ? name;
  final String ? type;
  final int ? size;
  final String ? collection;
  final Details ?details;
  final String ? status;
  final Links ?links;

  Album(
      {this.id,
      this.url,
      this.name,
      this.type,
      this.size,
      this.collection,
      this.details,
      this.status,
      this.links});

  factory Album.fromJson(Map<String ?, dynamic> json) {
    return Album(
      id: json['id'],
      url: json['url'],
      name: json['name'],
      type: json['type'],
      size: json['size'],
      collection: json['collection'],
      details: json['details'] != null ? Details.fromJson(json['details']) : null,
      status: json['status'],
      links: json['links'] != null ? Links.fromJson(json['links']) : null,
    );
  }

  Map<String ?, dynamic> toJson() {
    final Map<String ?, dynamic> data = new Map<String ?, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['name'] = this.name;
    data['type'] = this.type;
    data['size'] = this.size;
    data['collection'] = this.collection;
    data['status'] = this.status;
    if (this.details != null) {
      data['details'] = this.details!.toJson();
    }
    if (this.links != null) {
      data['links'] = this.links!.toJson();
    }
    return data;
  }
}

class Links {
  final Delete ?delete;

  Links({this.delete});

  factory Links.fromJson(Map<String ?, dynamic> json) {
    return Links(
      delete: json['delete'] != null ? Delete.fromJson(json['delete']) : null,
    );
  }

  Map<String ?, dynamic> toJson() {
    final Map<String ?, dynamic> data = new Map<String ?, dynamic>();
    if (this.delete != null) {
      data['delete'] = this.delete!.toJson();
    }
    return data;
  }
}

class Delete {
  final String ? href;
  final String ? method;

  Delete({this.href, this.method});

  factory Delete.fromJson(Map<String ?, dynamic> json) {
    return Delete(
      href: json['href'],
      method: json['method'],
    );
  }

  Map<String ?, dynamic> toJson() {
    final Map<String ?, dynamic> data = new Map<String ?, dynamic>();
    data['href'] = this.href;
    data['method'] = this.method;
    return data;
  }
}

class Details {
  final int ? width;
  final int ? height;
  final String ? ratio;

  Details({this.width, this.height, this.ratio});

  factory Details.fromJson(Map<String ?, dynamic> json) {
    return Details(
      width: json['width'],
      height: json['height'],
      ratio: json['ratio'],
    );
  }

  Map<String ?, dynamic> toJson() {
    final Map<String ?, dynamic> data = new Map<String ?, dynamic>();
    data['width'] = this.width;
    data['height'] = this.height;
    data['ratio'] = this.ratio;
    return data;
  }
}

class LinksX {
  final String ? first;
  final String ? last;
  final String ? prev;
  final String ? next;

  LinksX({this.first, this.last, this.prev, this.next});

  factory LinksX.fromJson(Map<String ?, dynamic> json) {
    return LinksX(
      first: json['first'],
      last: json['last'],
      prev: json['prev'] != null ? json['prev'] : null,
      next: json['next'] != null ? json['next'] : null,
    );
  }

  Map<String ?, dynamic> toJson() {
    final Map<String ?, dynamic> data = new Map<String ?, dynamic>();
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

class Meta {
  final int ? currentPage;
  final int ? from;
  final int ? lastPage;
  final String ? path;
  final int ? perPage;
  final int ? to;
  final int ? total;

  Meta(
      {this.currentPage,
      this.from,
      this.lastPage,
      this.path,
      this.perPage,
      this.to,
      this.total});

  factory Meta.fromJson(Map<String ?, dynamic> json) {
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

  Map<String ?, dynamic> toJson() {
    final Map<String ?, dynamic> data = new Map<String ?, dynamic>();
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
