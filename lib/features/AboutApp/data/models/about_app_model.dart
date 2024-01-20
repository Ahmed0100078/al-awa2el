import 'package:madaresco/features/AboutApp/domain/entities/about_app_entity.dart';

class AboutAppModel extends AboutAppEntity {
  final List<Data> ?data;

  AboutAppModel({this.data})
      : super(
            about:
                data!.firstWhere((element) => element.key == 'about').value ??
                    "",
      appearStudentDegrees:  data.firstWhere((element) => element.key == 'appear_student_degrees').value ?? "",
            name: 'app_name',
            showDeleteProfile:
                data.firstWhere((element) => element.key == 'delete_profile').value[0] ??
                    "");

  factory AboutAppModel.fromJson(Map<String, dynamic> json) {
    return AboutAppModel(
      data: json['data'] != null
          ? (json['data'] as List).map((i) => Data.fromJson(i)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  final String ?key;
  final dynamic value;

  Data({this.key, this.value});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      key: json['key'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['value'] = this.value;
    return data;
  }
}
