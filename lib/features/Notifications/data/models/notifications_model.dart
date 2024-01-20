import 'package:madaresco/features/Notifications/domain/entities/notification_entity.dart';

class NotificationsModel extends NotificationsEntity {
  final int ? count;
  final String ? link;
  final List<Data> ?data;

  NotificationsModel({this.count, this.link, this.data}) : super(notifications: data!);

  factory NotificationsModel.fromJson(Map<String ?, dynamic> json) {
    return NotificationsModel(
      count: json['count'],
      link: json['link'],
      data: json['data'] != null
          ? (json['data'] as List).map((i) => Data.fromJson(i)).toList()
          : null,
    );
  }

  Map<String ?, dynamic> toJson() {
    final Map<String ?, dynamic> data = new Map<String ?, dynamic>();
    data['count'] = this.count;
    data['link'] = this.link;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data extends NotificationEntity {
  final String ? id;
  final String ? avatar;
  final String ? title;
  final String ? outSideLink;
  final String  body;
  final String ? dashboardUrl;
  final String ? url;
  final dynamic date;
  final String ? formattedDate;
  final dynamic dataView;
  // ignore: non_constant_identifier_names
  final dynamic data_id;

  Data({
    this.id,
    this.avatar,
    this.title,
    required this.body,
    this.dashboardUrl,
    this.url,
    this.outSideLink="",
    this.date,
    this.formattedDate,
    this.dataView="",
    // ignore: non_constant_identifier_names
    this.data_id=0,
  }) : super(image: avatar!, time: formattedDate!, body: body, author: title!, dataId: data_id??0,outSideLink: outSideLink,view: dataView??"");

  factory Data.fromJson(Map<String ?, dynamic> json) {
    return Data(
      id: json['id'],
      avatar: json['avatar'],
      title: json['title'],
      body: json['body'],
      outSideLink: json['outside_link'],
      dashboardUrl: json['dashboard_url'],
      url: json['url'],
      date: json['date'],
      formattedDate: json['formated_date'],
      dataView: json['data_view'] != null ? json['data_view'] : null,
      data_id: json['data_id'] != null ? json['data_id'] : null,
    );
  }

  Map<String ?, dynamic> toJson() {
    final Map<String ?, dynamic> data = new Map<String ?, dynamic>();
    data['id'] = this.id;
    data['avatar'] = this.avatar;
    data['title'] = this.title;
    data['body'] = this.body;
    data['outside_link'] = this.outSideLink;
    data['dashboard_url'] = this.dashboardUrl;
    data['url'] = this.url;
    data['formated_date'] = this.formattedDate;
    if (this.date != null) {
      data['date'] = this.date!.toJson();
    }
    if (this.dataView != null) {
      data['data_view'] = this.dataView;
    }
    if (this.data_id != null) {
      data['data_id'] = this.data_id;
    }
    return data;
  }
}

class Date {
  final String ? date;
  final int ? timezoneType;
  final String ? timezone;

  Date({this.date, this.timezoneType, this.timezone});

  factory Date.fromJson(Map<String ?, dynamic> json) {
    return Date(
      date: json['date'],
      timezoneType: json['timezone_type'],
      timezone: json['timezone'],
    );
  }

  Map<String ?, dynamic> toJson() {
    final Map<String ?, dynamic> data = new Map<String ?, dynamic>();
    data['date'] = this.date;
    data['timezone_type'] = this.timezoneType;
    data['timezone'] = this.timezone;
    return data;
  }
}
