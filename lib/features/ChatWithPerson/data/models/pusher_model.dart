import 'package:madaresco/features/ChatWithPerson/domain/entities/pusher_entity.dart';

class PusherModel extends PusherEntity {
  final Data? data;

  PusherModel({this.data})
      : super(
            appId: data!.appId!,
            key: data.key!,
            cluster: data.options!.cluster ?? "",
            host: data.options!.host ?? "",
            port: data.options!.port ?? "",
            encrypted: data.options!.encrypted!);

  factory PusherModel.fromJson(Map<String, dynamic> json) {
    return PusherModel(
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
  final String? broadcaster;
  final String? key;
  final String? appId;
  final Options? options;

  Data({this.broadcaster, this.key, this.appId, this.options});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      broadcaster: json['broadcaster'],
      key: json['key'],
      appId: json['app_id'],
      options:
          json['options'] != null ? Options.fromJson(json['options']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['broadcaster'] = this.broadcaster;
    data['key'] = this.key;
    data['app_id'] = this.appId;
    if (this.options != null) {
      data['options'] = this.options!.toJson();
    }
    return data;
  }
}

class Options {
  final String? cluster;
  final bool? encrypted;
  var host;
  var port;
  final String? scheme;

  Options({this.cluster, this.encrypted, this.host, this.port, this.scheme});

  factory Options.fromJson(Map<String, dynamic> json) {
    return Options(
      cluster: json['cluster'] != null ? json['cluster'] : null,
      encrypted: json['encrypted'],
      host: json['host'],
      port: json['port'],
      scheme: json['scheme'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['encrypted'] = this.encrypted;
    data['host'] = this.host;
    data['port'] = this.port;
    data['scheme'] = this.scheme;
    if (this.cluster != null) {
      data['cluster'] = this.cluster;
    }
    return data;
  }
}
