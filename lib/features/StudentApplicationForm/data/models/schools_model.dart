class SchoolsModel {
  Data? data;
  Debug? debug;

  SchoolsModel({this.data, this.debug});

  SchoolsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    debug = json['debug'] != null ? new Debug.fromJson(json['debug']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.debug != null) {
      data['debug'] = this.debug!.toJson();
    }
    return data;
  }
}

class Data {
  String? label;
  List<School>? schools;

  Data({this.label, this.schools});

  Data.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    if (json['options'] != null) {
      schools = <School>[];
      json['options'].forEach((v) {
        schools!.add(new School.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    if (this.schools != null) {
      data['options'] = this.schools!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class School {
  late int id;
  String? name;
  String? email;
  String? logo;

  School({required this.id, this.name, this.email, this.logo});

  School.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['logo'] = this.logo;
    return data;
  }
}

class Debug {
  Database? database;
  Cache? cache;
  List<Profiling>? profiling;
  Memory? memory;

  Debug({this.database, this.cache, this.profiling, this.memory});

  Debug.fromJson(Map<String, dynamic> json) {
    database = json['database'] != null
        ? new Database.fromJson(json['database'])
        : null;
    cache = json['cache'] != null ? new Cache.fromJson(json['cache']) : null;
    if (json['profiling'] != null) {
      profiling = <Profiling>[];
      json['profiling'].forEach((v) {
        profiling!.add(new Profiling.fromJson(v));
      });
    }
    memory =
        json['memory'] != null ? new Memory.fromJson(json['memory']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.database != null) {
      data['database'] = this.database!.toJson();
    }
    if (this.cache != null) {
      data['cache'] = this.cache!.toJson();
    }
    if (this.profiling != null) {
      data['profiling'] = this.profiling!.map((v) => v.toJson()).toList();
    }
    if (this.memory != null) {
      data['memory'] = this.memory!.toJson();
    }
    return data;
  }
}

class Database {
  int? total;
  List<Items>? items;

  Database({this.total, this.items});

  Database.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? connection;
  String? query;
  double? time;

  Items({this.connection, this.query, this.time});

  Items.fromJson(Map<String, dynamic> json) {
    connection = json['connection'];
    query = json['query'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connection'] = this.connection;
    data['query'] = this.query;
    data['time'] = this.time;
    return data;
  }
}

class Cache {
  Hit? hit;
  Hit? miss;
  Hit? write;
  Forget? forget;

  Cache({this.hit, this.miss, this.write, this.forget});

  Cache.fromJson(Map<String, dynamic> json) {
    hit = json['hit'] != null ? new Hit.fromJson(json['hit']) : null;
    miss = json['miss'] != null ? new Hit.fromJson(json['miss']) : null;
    write = json['write'] != null ? new Hit.fromJson(json['write']) : null;
    forget =
        json['forget'] != null ? new Forget.fromJson(json['forget']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.hit != null) {
      data['hit'] = this.hit!.toJson();
    }
    if (this.miss != null) {
      data['miss'] = this.miss!.toJson();
    }
    if (this.write != null) {
      data['write'] = this.write!.toJson();
    }
    if (this.forget != null) {
      data['forget'] = this.forget!.toJson();
    }
    return data;
  }
}

class Hit {
  List<String>? keys;
  int? total;

  Hit({this.keys, this.total});

  Hit.fromJson(Map<String, dynamic> json) {
    keys = json['keys'].cast<String>();
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['keys'] = this.keys;
    data['total'] = this.total;
    return data;
  }
}

class Forget {
  List<Null>? keys;
  int? total;

  Forget({this.keys, this.total});

  Forget.fromJson(Map<String, dynamic> json) {
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['total'] = this.total;
    return data;
  }
}

class Profiling {
  String? event;
  double? time;

  Profiling({this.event, this.time});

  Profiling.fromJson(Map<String, dynamic> json) {
    event = json['event'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event'] = this.event;
    data['time'] = this.time;
    return data;
  }
}

class Memory {
  int? usage;
  int? peak;

  Memory({this.usage, this.peak});

  Memory.fromJson(Map<String, dynamic> json) {
    usage = json['usage'];
    peak = json['peak'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['usage'] = this.usage;
    data['peak'] = this.peak;
    return data;
  }
}
