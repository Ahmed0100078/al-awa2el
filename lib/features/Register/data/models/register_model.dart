import 'package:madaresco/features/Register/domain/entities/item_entity.dart';

class SchoolModel extends Item {
  final Data ?data;
  final String ?token;

  SchoolModel({this.data, this.token}) : super(name: data!.name, id: data.id);

  factory SchoolModel.fromJson(Map<String, dynamic> json) {
    return SchoolModel(
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  final int ?id;
  final String ?name;
  final String ?email;
  final String ?logo;

  Data({this.id, this.name, this.email, this.logo});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      logo: json['logo'],
    );
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
