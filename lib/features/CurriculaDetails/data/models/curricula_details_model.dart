import 'package:madaresco/features/CurriculaDetails/domain/entities/curricula_details_entity.dart';

class CurriculaDetailsModel extends CurriculaDetailsEntity {
  final Data? data;

  CurriculaDetailsModel({this.data})
      : super(
            name: data!.name!,
            image: data.avatar!.url!,
            pdfLink: data.pdf!.url ?? '');

  factory CurriculaDetailsModel.fromJson(dynamic json) {
    return CurriculaDetailsModel(
        data: json["data"] != null ? Data.fromJson(json["data"]) : null);
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (data != null) {
      map["data"] = data!.toJson();
    }
    return map;
  }
}

class Data {
  int? id;
  String? name;
  String? term;
  Pdf? pdf;
  Avatar? avatar;

  Data({this.id, this.name, this.term, this.pdf, this.avatar});

  factory Data.fromJson(dynamic json) {
    return Data(
        id: json["id"],
        name: json["name"],
        term: json["term"],
        pdf: json["pdf"] != null ? Pdf.fromJson(json["pdf"]) : null,
        avatar:
            json["avatar"] != null ? Avatar.fromJson(json["avatar"]) : null);
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    map["term"] = term;
    if (pdf != null) {
      map["pdf"] = pdf!.toJson();
    }
    if (avatar != null) {
      map["avatar"] = avatar!.toJson();
    }
    return map;
  }
}

class Avatar {
  int? id;
  String? url;
  String? name;
  String? type;
  int? size;
  String? collection;
  Details? details;
  dynamic status;
  Links? links;

  Avatar(
      {this.id,
      this.url,
      this.name,
      this.type,
      this.size,
      this.collection,
      this.details,
      this.status,
      this.links});

  factory Avatar.fromJson(dynamic json) {
    return Avatar(
        id: json["id"],
        url: json["url"],
        name: json["name"],
        type: json["type"],
        size: json["size"],
        collection: json["collection"],
        details:
            json["details"] != null ? Details.fromJson(json["details"]) : null,
        status: json["status"],
        links: json["links"] != null ? Links.fromJson(json["links"]) : null);
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["url"] = url;
    map["name"] = name;
    map["type"] = type;
    map["size"] = size;
    map["collection"] = collection;
    if (details != null) {
      map["details"] = details!.toJson();
    }
    map["status"] = status;
    if (links != null) {
      map["links"] = links!.toJson();
    }
    return map;
  }
}

class Links {
  Delete? delete;

  Links({this.delete});

  factory Links.fromJson(dynamic json) {
    return Links(
        delete:
            json["delete"] != null ? Delete.fromJson(json["delete"]) : null);
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (delete != null) {
      map["delete"] = delete!.toJson();
    }
    return map;
  }
}

class Delete {
  String? href;
  String? method;

  Delete({this.href, this.method});

  factory Delete.fromJson(dynamic json) {
    return Delete(href: json["href"], method: json["method"]);
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["href"] = href;
    map["method"] = method;
    return map;
  }
}

class Details {
  dynamic width;
  dynamic height;
  dynamic ratio;
  dynamic duration;

  Details({this.width, this.height, this.ratio, this.duration});

  Details.fromJson(dynamic json) {
    width = json["width"];
    height = json["height"];
    ratio = json["ratio"];
    duration = json["duration"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["width"] = width;
    map["height"] = height;
    map["ratio"] = ratio;
    map["duration"] = duration;
    return map;
  }
}

class Pdf {
  int? id;
  String? url;
  String? name;
  String? type;
  int? size;
  String? collection;
  Details? details;
  dynamic status;
  Links? links;

  Pdf(
      {this.id,
      this.url,
      this.name,
      this.type,
      this.size,
      this.collection,
      this.details,
      this.status,
      this.links});

  factory Pdf.fromJson(dynamic json) {
    return Pdf(
        id: json["id"],
        url: json["url"],
        name: json["name"],
        type: json["type"],
        size: json["size"],
        collection: json["collection"],
        details:
            json["details"] != null ? Details.fromJson(json["details"]) : null,
        status: json["status"],
        links: json["links"] != null ? Links.fromJson(json["links"]) : null);
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["url"] = url;
    map["name"] = name;
    map["type"] = type;
    map["size"] = size;
    map["collection"] = collection;
    if (details != null) {
      map["details"] = details!.toJson();
    }
    map["status"] = status;
    if (links != null) {
      map["links"] = links!.toJson();
    }
    return map;
  }
}
