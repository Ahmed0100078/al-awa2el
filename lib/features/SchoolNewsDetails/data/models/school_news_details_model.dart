import 'package:madaresco/features/SchoolNewsDetails/domain/entities/school_news_details_entity.dart';

class SchoolNewsDetailsModel extends SchoolNewsDetailsEntity {
  final Data ?data;

  SchoolNewsDetailsModel({this.data})
      : super(
            image: data!.avatar!,
            date: data.createdAt!,
            description: data.body!,
            number: data.viewsCount!,
            title: data.title!);

  factory SchoolNewsDetailsModel.fromJson(Map<String, dynamic> json) {
    return SchoolNewsDetailsModel(
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
  final String? title;
  final String? body;
  final int ?isUrgent;
  final int ?viewsCount;
  final String ?createdAt;
  final String ?avatar;
  final double ?ratio;

  Data(
      {this.id,
      this.title,
      this.body,
      this.isUrgent,
      this.viewsCount,
      this.createdAt,
      this.avatar,
      this.ratio});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      isUrgent: json['is_urgent'],
      viewsCount: json['views_count'],
      createdAt: json['created_at'],
      avatar: json['avatar'],
      ratio: double.parse(json['ratio'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    data['is_urgent'] = this.isUrgent;
    data['views_count'] = this.viewsCount;
    data['created_at'] = this.createdAt;
    data['avatar'] = this.avatar;
    data['ratio'] = this.ratio;
    return data;
  }
}
