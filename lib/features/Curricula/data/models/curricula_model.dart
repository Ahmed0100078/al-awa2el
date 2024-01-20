import 'package:madaresco/features/Curricula/domain/entities/curricula_entity.dart';

// ignore: must_be_immutable
class CurriculaModel extends CurriculaEntity {
  List<Data>? _data;
  Links? _links;
  Meta? _meta;

  List<Data>? get data => _data;

  Links? get links => _links;

  Meta? get meta => _meta;

  CurriculaModel({List<Data>? data, Links? links, Meta? meta})
      : super(curricals: data!, next: links!.next ?? "") {
    _data = data;
    _links = links;
    _meta = meta;
  }

  factory CurriculaModel.map(dynamic obj) {
    return CurriculaModel(
        data: obj["data"] != null
            ? (obj["data"] as List).map((e) => Data.map(e)).toList()
            : [],
        links: obj["links"] != null ? Links.map(obj["links"]) : null,
        meta: obj["meta"] != null ? Meta.map(obj['meta']) : null);
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (_data != null) {
      map["data"] = _data!.map((v) => v.toMap()).toList();
    }
    map["links"] = _links;
    map["meta"] = _meta;
    return map;
  }
}

class Meta {
  int? _currentPage;
  int? _from;
  int? _lastPage;
  String? _path;
  int? _perPage;
  int? _to;
  int? _total;

  int? get currentPage => _currentPage;

  int? get from => _from;

  int? get lastPage => _lastPage;

  String? get path => _path;

  int? get perPage => _perPage;

  int? get to => _to;

  int? get total => _total;

  Meta(
      {int? currentPage,
      int? from,
      int? lastPage,
      String? path,
      int? perPage,
      int? to,
      int? total}) {
    _currentPage = currentPage ?? 0;
    _from = from ?? 0;
    _lastPage = lastPage ?? 0;
    _path = path ?? "";
    _perPage = perPage ?? 0;
    _to = to ?? 0;
    _total = total ?? 0;
  }

  factory Meta.map(dynamic obj) {
    return Meta(
        currentPage: obj["currentPage"],
        from: obj["from"],
        lastPage: obj["lastPage"],
        path: obj["path"],
        perPage: obj["perPage"],
        to: obj["to"],
        total: obj["total"]);
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["currentPage"] = _currentPage;
    map["from"] = _from;
    map["lastPage"] = _lastPage;
    map["path"] = _path;
    map["perPage"] = _perPage;
    map["to"] = _to;
    map["total"] = _total;
    return map;
  }
}

class Links {
  String? _first;
  String? _last;
  String? _prev;
  String? _next;

  String? get first => _first;

  String? get last => _last;

  String? get prev => _prev;

  String? get next => _next;

  Links({String? first, String? last, String? prev, String? next}) {
    _first = first;
    _last = last;
    _prev = prev;
    _next = next;
  }

  factory Links.map(dynamic obj) {
    return Links(
      first: obj["first"],
      last: obj["last"],
      prev: obj["prev"],
      next: obj["next"],
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["first"] = _first;
    map["last"] = _last;
    map["prev"] = _prev;
    map["next"] = _next;
    return map;
  }
}

// ignore: must_be_immutable
class Data extends Curricular {
  int _id = 0;
  String _name = '';
  String? _term;
  Pdf? _pdf;
  Avatar? _avatar;

  int get id => _id;

  String get name => _name;

  String? get term => _term;

  Pdf? get pdf => _pdf;

  Avatar? get avatar => _avatar;

  Data(
      {required int id,
      required String name,
      String? term,
      Pdf? pdf,
      Avatar? avatar})
      : super(name: name, photo: avatar!.url!, id: id) {
    _id = id;
    _name = name;
    _term = term;
    _pdf = pdf!;
    _avatar = avatar;
  }

  factory Data.map(dynamic obj) {
    return Data(
        id: obj["id"],
        name: obj["name"],
        term: obj["term"],
        pdf: obj["pdf"] != null ? Pdf.map(obj["pdf"]) : null,
        avatar: obj["avatar"] != null ? Avatar.map(obj["avatar"]) : null);
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["term"] = _term;
    map["pdf"] = _pdf;
    map["avatar"] = _avatar;
    return map;
  }
}

class Avatar {
  int? _id;
  String? _url;
  String? _name;
  String? _type;
  int? _size;
  String? _collection;
  Details? _details;
  dynamic _status;
  Linkss? _links;

  int? get id => _id;

  String? get url => _url;

  String? get name => _name;

  String? get type => _type;

  int? get size => _size;

  String? get collection => _collection;

  Details? get details => _details;

  dynamic get status => _status;

  Linkss? get links => _links;

  Avatar(
      {int? id,
      String? url,
      String? name,
      String? type,
      int? size,
      String? collection,
      Details? details,
      dynamic status,
      Linkss? links}) {
    _id = id;
    _url = url;
    _name = name;
    _type = type;
    _size = size;
    _collection = collection;
    _details = details;
    _status = status;
    _links = links;
  }

  factory Avatar.map(dynamic obj) {
    return Avatar(
        id: obj["id"],
        url: obj["url"],
        name: obj["name"],
        type: obj["type"],
        size: obj["size"],
        collection: obj["collection"],
        details: obj["details"] != null ? Details.map(obj["details"]) : null,
        status: obj["status"],
        links: obj["links"] != null ? Linkss.map(obj["links"]) : null);
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["url"] = _url;
    map["name"] = _name;
    map["type"] = _type;
    map["size"] = _size;
    map["collection"] = _collection;
    map["details"] = _details;
    map["status"] = _status;
    map["links"] = _links;
    return map;
  }
}

class Linkss {
  Delete? _delete;

  Delete? get delete => _delete;

  Linkss({Delete? delete}) {
    _delete = delete;
  }

  factory Linkss.map(dynamic obj) {
    return Linkss(delete: Delete.map(obj["delete"]));
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["delete"] = _delete;
    return map;
  }
}

class Delete {
  String? _href;
  String? _method;

  String? get href => _href;

  String? get method => _method;

  Delete({String? href, String? method}) {
    _href = href;
    _method = method;
  }

  factory Delete.map(dynamic obj) {
    return Delete(href: obj["href"], method: obj["method"]);
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["href"] = _href;
    map["method"] = _method;
    return map;
  }
}

class Details {
  dynamic _width;
  dynamic _height;
  dynamic _ratio;
  dynamic _duration;

  dynamic get width => _width;

  dynamic get height => _height;

  dynamic get ratio => _ratio;

  dynamic get duration => _duration;

  Details({dynamic width, dynamic height, dynamic ratio, dynamic duration}) {
    _width = width;
    _height = height;
    _ratio = ratio;
    _duration = duration;
  }

  factory Details.map(dynamic obj) {
    return Details(
      width: obj["width"],
      height: obj["height"],
      ratio: obj["ratio"],
      duration: obj["duration"],
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["width"] = _width;
    map["height"] = _height;
    map["ratio"] = _ratio;
    map["duration"] = _duration;
    return map;
  }
}

class Pdf {
  int? _id;
  String? _url;
  String? _name;
  String? _type;
  int? _size;
  String? _collection;
  dynamic _status;
  Linkss? _links;

  int? get id => _id;

  String? get url => _url;

  String? get name => _name;

  String? get type => _type;

  int? get size => _size;

  String? get collection => _collection;

  dynamic get status => _status;

  Linkss? get links => _links;

  Pdf(
      {int? id,
      String? url,
      String? name,
      String? type,
      int? size,
      String? collection,
      dynamic status,
      Linkss? links}) {
    _id = id!;
    _url = url!;
    _name = name!;
    _type = type!;
    _size = size!;
    _collection = collection!;
    _status = status;
    _links = links!;
  }

  factory Pdf.map(dynamic obj) {
    return Pdf(
        id: obj["id"],
        url: obj["url"],
        name: obj["name"],
        type: obj["type"],
        size: obj["size"],
        collection: obj["collection"],
        status: obj["status"],
        links: obj["links"] != null ? Linkss.map(obj["links"]) : null);
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["url"] = _url;
    map["name"] = _name;
    map["type"] = _type;
    map["size"] = _size;
    map["collection"] = _collection;
    map["status"] = _status;
    map["links"] = _links;
    return map;
  }
}
