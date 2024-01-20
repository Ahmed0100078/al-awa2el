import 'package:madaresco/features/ManagerWord/domain/entities/manager_word_entity.dart';

class ManagerWordModel extends ManagerWordEntity {
  final Data ?data;

  ManagerWordModel({this.data})
      : super(name: data!.adminName!, word: data.adminWord!, image: data.image!.url??"");

  factory ManagerWordModel.fromJson(Map<String, dynamic> json) {
    return ManagerWordModel(
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
  final String ?adminName;
  final String ?adminWord;
  final Image ?image;

  Data({this.adminName, this.adminWord, this.image});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      adminName: json['admin-name'],
      adminWord: json['admin-word'],
      image: json['image'] != null ? Image.fromJson(json['image']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['admin-name'] = this.adminName;
    data['admin-word'] = this.adminWord;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    return data;
  }
}

class Image {
  final int ?id;
  final String ?url;
  final String ?name;
  final String ?type;
  final int ?size;
  final String ?collection;
  final Links ?links;

  Image({this.id, this.url, this.name, this.type, this.size, this.collection, this.links});

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      id: json['id'],
      url: json['url'],
      name: json['name'],
      type: json['type'],
      size: json['size'],
      collection: json['collection'],
      links: json['links'] != null ? Links.fromJson(json['links']) : null,
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
