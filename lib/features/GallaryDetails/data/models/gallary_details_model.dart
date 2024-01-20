import 'package:madaresco/features/GallaryDetails/domain/entities/gallary_details_entities.dart';

class GallaryDetailsModel extends GallaryDetailsEntity {
  final Data ?data;

  GallaryDetailsModel({this.data})
      : super(name: data!.name!, images: data.album!.map((e) => e.url!).toList());

  factory GallaryDetailsModel.fromJson(Map<String, dynamic> json) {
    return GallaryDetailsModel(
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  final int ?id;
  final String? name;
  final String ?avatar;
  final List<Album>? album;
  final double ?ratio;
  final String ?createdAt;

  Data({this.id, this.name, this.avatar, this.album, this.ratio, this.createdAt});

  factory Data.fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
  final int ?id;
  final String ?url;
  final String ?name;
  final String ?type;
  final int ?size;
  final String ?collection;
  final Links ?links;
  final String ?status;

  Album(
      {this.id,
      this.url,
      this.name,
      this.type,
      this.size,
      this.collection,
      this.links,
      this.status});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      url: json['url'],
      name: json['name'],
      type: json['type'],
      size: json['size'],
      collection: json['collection'],
      links: json['links'] != null ? Links.fromJson(json['links']) : null,
      status: json['status'] != null ? json['status'] : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['name'] = this.name;
    data['type'] = this.type;
    data['size'] = this.size;
    data['collection'] = this.collection;
    if (this.links != null) {
      data['links'] = this.links!.toJson();
    }
    if (this.status != null) {
      data['status'] = this.status;
    }
    return data;
  }
}

class Links {
  final Delete ?delete;

  Links({this.delete});

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      delete: json['delete'] != null ? Delete.fromJson(json['delete']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.delete != null) {
      data['delete'] = this.delete!.toJson();
    }
    return data;
  }
}

class Delete {
  final String ?href;
  final String ?method;

  Delete({this.href, this.method});

  factory Delete.fromJson(Map<String, dynamic> json) {
    return Delete(
      href: json['href'],
      method: json['method'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    data['method'] = this.method;
    return data;
  }
}
