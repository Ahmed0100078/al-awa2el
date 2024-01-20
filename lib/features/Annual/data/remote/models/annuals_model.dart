import 'package:madaresco/features/Annual/domain/entities/annual_entity.dart';

class AnnualsModel extends AnnualEntity {
  final String ?emptyMessage;
  final Paid ?paid;
  final PartiallyPaid ?partiallyPaid;
  // ignore: non_constant_identifier_names
  final NotPaid ?not_paid;

  // ignore: non_constant_identifier_names
  AnnualsModel({this.emptyMessage, this.paid, this.partiallyPaid, this.not_paid})
      : super(paids: paid!.data!, partialyPaid: partiallyPaid!.data!, notPaid: not_paid!.data!);

  factory AnnualsModel.fromJson(Map<String, dynamic> json) {
    return AnnualsModel(
      emptyMessage: json['empty_message'],
      paid: json['paid'] != null ? Paid.fromJson(json['paid']) : null,
      partiallyPaid:
          json['partially_paid'] != null ? PartiallyPaid.fromJson(json['partially_paid']) : null,
      not_paid: json['not_paid'] != null ? NotPaid.fromJson(json['not_paid']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['empty_message'] = this.emptyMessage;
    if (this.paid != null) {
      data['paid'] = this.paid!.toJson();
    }
    if (this.partiallyPaid != null) {
      data['partially_paid'] = this.partiallyPaid!.toJson();
    }
    if (this.not_paid != null) {
      data['not_paid'] = this.not_paid!.toJson();
    }
    return data;
  }
}

class PartiallyPaid {
  final String ?group;
  final String ?status;
  final List<Data>? data;

  PartiallyPaid({this.group, this.status, this.data});

  factory PartiallyPaid.fromJson(Map<String, dynamic> json) {
    return PartiallyPaid(
      group: json['group'],
      status: json['status'],
      data: json['data'] != null
          ? (json['data'] as List).map((i) => Data.fromJson(i)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['group'] = this.group;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data extends Annuals {
  final dynamic date;
  final dynamic price;
  final dynamic delete;

  Data({required this.date, this.price, this.delete}) : super(date: date, amount: price.toString());

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      date: json['date'],
      price: json['price'],
      delete: json['delete'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['price'] = this.price;
    data['delete'] = this.delete;
    return data;
  }
}

class Paid {
  final String ?group;
  final String ?status;
  final List<Data>? data;

  Paid({this.group, this.status, this.data});

  factory Paid.fromJson(Map<String, dynamic> json) {
    return Paid(
      group: json['group'],
      status: json['status'],
      data: json['data'] != null
          ? (json['data'] as List).map((i) => Data.fromJson(i)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['group'] = this.group;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotPaid {
  final String ?group;
  final String ?status;
  final List<Data> ?data;

  NotPaid({this.group, this.status, this.data});

  factory NotPaid.fromJson(Map<String, dynamic> json) {
    return NotPaid(
      group: json['group'],
      status: json['status'],
      data: json['data'] != null
          ? (json['data'] as List).map((i) => Data.fromJson(i)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['group'] = this.group;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
