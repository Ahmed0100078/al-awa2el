import '../../domain/entities/item_entity.dart';

class GradesModel extends ItemsEntity{
  final List<Data>? data;

  GradesModel({
    this.data,
  }) : super(items: data);

  factory GradesModel.fromJson(Map<String, dynamic> json) {
    return GradesModel(
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
      );}
}

//the new model
class Data extends Item{
  final int? id;
  final String? name;

  Data({
    this.id,
    this.name,
  }) : super(name: name, id: id);

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
      );
}

// class Data {
//   String? label;
//   List<Option>? options;
//   Data({
//     this.label,
//     this.options,
//   });
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         label: json["label"],
//         options:
//             List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
//       );
//   Map<String, dynamic> toJson() => {
//         "label": label,
//         "options": List<dynamic>.from(options!.map((x) => x.toJson())),
//       };
// }

// class Option extends Item{
//   int? id;
//   String? name;
//   Option({
//     this.id,
//     this.name,
//   }) : super(id: id, name: name);
//   factory Option.fromJson(Map<String, dynamic> json) => Option(
//         id: json["id"],
//         name: json["name"],
//       );
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//       };
// }
