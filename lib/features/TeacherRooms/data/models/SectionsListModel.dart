class SectionsListModel {
  List<Section> ?sections;
  Debug ?debug;

  SectionsListModel({this.sections, this.debug});

  SectionsListModel.fromJson(Map<String ?, dynamic> json) {
    if (json['data'] != null) {
      sections = new List<Section>.empty(growable: true);
      json['data'].forEach((v) {
        sections!.add(new Section.fromJson(v));
      });
    }
    debug = json['debug'] != null ? new Debug.fromJson(json['debug']) : null;
  }

  Map<String ?, dynamic> toJson() {
    final Map<String ?, dynamic> data = new Map<String ?, dynamic>();
    if (this.sections != null) {
      data['data'] = this.sections!.map((v) => v.toJson()).toList();
    }
    if (this.debug != null) {
      data['debug'] = this.debug!.toJson();
    }
    return data;
  }
}

class Section {
  int ? id;
  String ? name;

  Section({this.id, this.name});

  Section.fromJson(Map<String ?, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String ?, dynamic> toJson() {
    final Map<String ?, dynamic> data = new Map<String ?, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Debug {
  Database ?database;
  Cache ?cache;
  List<Profiling> ?profiling;
  Memory ?memory;

  Debug({this.database, this.cache, this.profiling, this.memory});

  Debug.fromJson(Map<String ?, dynamic> json) {
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

  Map<String ?, dynamic> toJson() {
    final Map<String ?, dynamic> data = new Map<String ?, dynamic>();
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
  int ? total;
  List<Items> ?items;

  Database({this.total, this.items});

  Database.fromJson(Map<String ?, dynamic> json) {
    total = json['total'];
    if (json['items'] != null) {
      items = new List<Items>.empty(growable: true);
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String ?, dynamic> toJson() {
    final Map<String ?, dynamic> data = new Map<String ?, dynamic>();
    data['total'] = this.total;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String ? connection;
  String ? query;
  double ? time;

  Items({this.connection, this.query, this.time});

  Items.fromJson(Map<String ?, dynamic> json) {
    connection = json['connection'];
    query = json['query'];
    time = json['time'];
  }

  Map<String ?, dynamic> toJson() {
    final Map<String ?, dynamic> data = new Map<String ?, dynamic>();
    data['connection'] = this.connection;
    data['query'] = this.query;
    data['time'] = this.time;
    return data;
  }
}

class Cache {
  Hit ?hit;
  Hit ?miss;
  Hit ?write;
  Forget ?forget;

  Cache({this.hit, this.miss, this.write, this.forget});

  Cache.fromJson(Map<String ?, dynamic> json) {
    hit = json['hit'] != null ? new Hit.fromJson(json['hit']) : null;
    miss = json['miss'] != null ? new Hit.fromJson(json['miss']) : null;
    write = json['write'] != null ? new Hit.fromJson(json['write']) : null;
    forget =
        json['forget'] != null ? new Forget.fromJson(json['forget']) : null;
  }

  Map<String ?, dynamic> toJson() {
    final Map<String ?, dynamic> data = new Map<String ?, dynamic>();
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
  List<String ?>? keys;
  int ? total;

  Hit({this.keys, this.total});

  Hit.fromJson(Map<String ?, dynamic> json) {
    keys = json['keys'].cast<String ?>();
    total = json['total'];
  }

  Map<String ?, dynamic> toJson() {
    final Map<String ?, dynamic> data = new Map<String ?, dynamic>();
    data['keys'] = this.keys;
    data['total'] = this.total;
    return data;
  }
}

class Forget {
  List<Null> ?keys;
  int ? total;

  Forget({this.keys, this.total});

  Forget.fromJson(Map<String ?, dynamic> json) {
    // if (json['keys'] != null) {
    //   keys = new List<Null>();
    //   json['keys'].forEach((v) {
    //     keys.add(new Null.fromJson(v));
    //   });
    // }
    total = json['total'];
  }

  Map<String ?, dynamic> toJson() {
    final Map<String ?, dynamic> data = new Map<String ?, dynamic>();
    // if (this.keys != null) {
    //   data['keys'] = this.keys.map((v) => v.toJson()).toList();
    // }
    data['total'] = this.total;
    return data;
  }
}

class Profiling {
  String ? event;
  double ? time;

  Profiling({this.event, this.time});

  Profiling.fromJson(Map<String ?, dynamic> json) {
    event = json['event'];
    time = json['time'];
  }

  Map<String ?, dynamic> toJson() {
    final Map<String ?, dynamic> data = new Map<String ?, dynamic>();
    data['event'] = this.event;
    data['time'] = this.time;
    return data;
  }
}

class Memory {
  int ? usage;
  int ? peak;

  Memory({this.usage, this.peak});

  Memory.fromJson(Map<String ?, dynamic> json) {
    usage = json['usage'];
    peak = json['peak'];
  }

  Map<String ?, dynamic> toJson() {
    final Map<String ?, dynamic> data = new Map<String ?, dynamic>();
    data['usage'] = this.usage;
    data['peak'] = this.peak;
    return data;
  }
}

class Autogenerated {
  List<Data> ?data;
  Debug ?debug;

  Autogenerated({this.data, this.debug});

  Autogenerated.fromJson(Map<String ?, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>.empty(growable: true);
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    debug = json['debug'] != null ? new Debug.fromJson(json['debug']) : null;
  }

  Map<String ?, dynamic> toJson() {
    final Map<String ?, dynamic> data = new Map<String ?, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.debug != null) {
      data['debug'] = this.debug!.toJson();
    }
    return data;
  }
}

class Data {
  int ? id;
  String ? name;

  Data({this.id, this.name});

  Data.fromJson(Map<String ?, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String ?, dynamic> toJson() {
    final Map<String ?, dynamic> data = new Map<String ?, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
