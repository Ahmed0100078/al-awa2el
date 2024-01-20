class FilteredStudentsModels {
  List<Student>? students;
  Links? links;
  Meta? meta;
  Debug? debug;

  FilteredStudentsModels({this.students, this.links, this.meta, this.debug});

  FilteredStudentsModels.fromJson(Map<String?, dynamic> json) {
    print(json);
    if (json['data'] != null) {
      students = new List<Student>.empty(growable: true);
      json['data'].forEach((v) {
        students!.add(new Student.fromJson(v));
      });
    }
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    debug = json['debug'] != null ? new Debug.fromJson(json['debug']) : null;
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    if (this.students != null) {
      data['data'] = this.students!.map((v) => v.toJson()).toList();
    }
    if (this.links != null) {
      data['links'] = this.links!.toJson();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    if (this.debug != null) {
      data['debug'] = this.debug!.toJson();
    }
    return data;
  }
}

class Student {
  int? id;
  String? name;
  String? email;
  String? mobile;
  String? avatar;
  Section? section;
  var rateStudent;
  var preferenceStudent;
  var about;
  String? type;
  bool? isConnected;
  bool? isActive;
  School? school;
  Location? location;
  List<Warnings>? warnings;

  Student(
      {this.id,
      this.name,
      this.email,
      this.mobile,
      this.avatar,
      this.section,
      this.rateStudent,
      this.preferenceStudent,
      this.about,
      this.type,
      this.isConnected,
      this.isActive,
      this.school,
      this.location,
      this.warnings});

  Student.fromJson(Map<String?, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'] != null ? json['email'] : null;
    mobile = json['mobile'] != null ? json['mobile'] : null;
    avatar = json['avatar'] != null ? json['avatar'] : null;
    section =
        json['section'] != null ? new Section.fromJson(json['section']) : null;
    rateStudent = json['rate_student'];
    preferenceStudent = json['preference_student'];
    about = json['about'];
    type = json['type'];
    isConnected = json['is_connected'];
    isActive = json['is_active'];
    school =
        json['school'] != null ? new School.fromJson(json['school']) : null;
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    if (json['warnings'] != null) {
      warnings = new List<Warnings>.empty(growable: true);
      json['warnings'].forEach((v) {
        warnings!.add(new Warnings.fromJson(v));
      });
    }
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['avatar'] = this.avatar;
    if (this.section != null) {
      data['section'] = this.section!.toJson();
    }
    data['rate_student'] = this.rateStudent;
    data['preference_student'] = this.preferenceStudent;
    data['about'] = this.about;
    data['type'] = this.type;
    data['is_connected'] = this.isConnected;
    data['is_active'] = this.isActive;
    if (this.school != null) {
      data['school'] = this.school!.toJson();
    }
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    if (this.warnings != null) {
      data['warnings'] = this.warnings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Section {
  int? id;
  String? name;
  Grade? grade;

  Section({this.id, this.name, this.grade});

  Section.fromJson(Map<String?, dynamic> json) {
    id = json['id'];
    name = json['name'];
    grade = json['grade'] != null ? new Grade.fromJson(json['grade']) : null;
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.grade != null) {
      data['grade'] = this.grade!.toJson();
    }
    return data;
  }
}

class Grade {
  int? id;
  String? name;
  Stage? stage;

  Grade({this.id, this.name, this.stage});

  Grade.fromJson(Map<String?, dynamic> json) {
    id = json['id'];
    name = json['name'];
    stage = json['stage'] != null ? new Stage.fromJson(json['stage']) : null;
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.stage != null) {
      data['stage'] = this.stage!.toJson();
    }
    return data;
  }
}

class Stage {
  int? id;
  String? name;

  Stage({this.id, this.name});

  Stage.fromJson(Map<String?, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class School {
  int? id;
  String? name;
  String? logo;
  String? schoolCode;

  School({this.id, this.name, this.logo, this.schoolCode});

  School.fromJson(Map<String?, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    schoolCode = json['school_code'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['school_code'] = this.schoolCode;
    return data;
  }
}

class Location {
  String? lat;
  String? lng;

  Location({this.lat, this.lng});

  Location.fromJson(Map<String?, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class Warnings {
  int? id;
  String? reason;
  String? date;

  Warnings({this.id, this.reason, this.date});

  Warnings.fromJson(Map<String?, dynamic> json) {
    id = json['id'];
    reason = json['reason'];
    date = json['date'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['id'] = this.id;
    data['reason'] = this.reason;
    data['date'] = this.date;
    return data;
  }
}

class Links {
  String? first;
  String? last;
  Null prev;
  Null next;

  Links({this.first, this.last, this.prev, this.next});

  Links.fromJson(Map<String?, dynamic> json) {
    first = json['first'];
    last = json['last'];
    prev = json['prev'];
    next = json['next'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['first'] = this.first;
    data['last'] = this.last;
    data['prev'] = this.prev;
    data['next'] = this.next;
    return data;
  }
}

class Meta {
  int? currentPage;
  int? from;
  int? lastPage;
  String? path;
  int? perPage;
  int? to;
  int? total;

  Meta(
      {this.currentPage,
      this.from,
      this.lastPage,
      this.path,
      this.perPage,
      this.to,
      this.total});

  Meta.fromJson(Map<String?, dynamic> json) {
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
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

class Debug {
  Database? database;
  Cache? cache;
  List<Profiling>? profiling;
  Memory? memory;

  Debug({this.database, this.cache, this.profiling, this.memory});

  Debug.fromJson(Map<String?, dynamic> json) {
    database = json['database'] != null
        ? new Database.fromJson(json['database'])
        : null;
    cache = json['cache'] != null ? new Cache.fromJson(json['cache']) : null;
    if (json['profiling'] != null) {
      profiling = new List<Profiling>.empty(growable: true);
      json['profiling'].forEach((v) {
        profiling!.add(new Profiling.fromJson(v));
      });
    }
    memory =
        json['memory'] != null ? new Memory.fromJson(json['memory']) : null;
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
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

  Database.fromJson(Map<String?, dynamic> json) {
    total = json['total'];
    if (json['items'] != null) {
      items = new List<Items>.empty(growable: true);
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
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
  num? time;

  Items({this.connection, this.query, this.time});

  Items.fromJson(Map<String?, dynamic> json) {
    connection = json['connection'];
    query = json['query'];
    time = json['time'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
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

  Cache.fromJson(Map<String?, dynamic> json) {
    hit = json['hit'] != null ? new Hit.fromJson(json['hit']) : null;
    miss = json['miss'] != null ? new Hit.fromJson(json['miss']) : null;
    write = json['write'] != null ? new Hit.fromJson(json['write']) : null;
    forget =
        json['forget'] != null ? new Forget.fromJson(json['forget']) : null;
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
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
  List<String?>? keys;
  int? total;

  Hit({this.keys, this.total});

  Hit.fromJson(Map<String?, dynamic> json) {
    keys = json['keys'].cast<String?>();
    total = json['total'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['keys'] = this.keys;
    data['total'] = this.total;
    return data;
  }
}

class Forget {
  List<Null>? keys;
  int? total;

  Forget({this.keys, this.total});

  Forget.fromJson(Map<String?, dynamic> json) {
    // if (json['keys'] != null) {
    //   keys = new List<Null>();
    //   json['keys'].forEach((v) {
    //     keys.add(new Null.fromJson(v));
    //   });
    // }
    total = json['total'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    // if (this.keys != null) {
    //   data['keys'] = this.keys.map((v) => v.toJson()).toList();
    // }
    data['total'] = this.total;
    return data;
  }
}

class Profiling {
  String? event;
  num? time;

  Profiling({this.event, this.time});

  Profiling.fromJson(Map<String?, dynamic> json) {
    event = json['event'];
    time = json['time'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['event'] = this.event;
    data['time'] = this.time;
    return data;
  }
}

class Memory {
  int? usage;
  int? peak;

  Memory({this.usage, this.peak});

  Memory.fromJson(Map<String?, dynamic> json) {
    usage = json['usage'];
    peak = json['peak'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['usage'] = this.usage;
    data['peak'] = this.peak;
    return data;
  }
}
