import 'dart:io';
import 'package:equatable/equatable.dart';

class SendEntity extends Equatable {
  final String? name,
      email,
      password,
      confirmPassword,
      mobile,
      city,
      country,
      managerName,
      address;
  final int? sectionId, schoolId;
  final File? image;

  const SendEntity({
    required this.name,
    this.email,
    required this.password,
    required this.confirmPassword,
    this.mobile,
    this.city,
    this.country,
    this.managerName,
    this.sectionId,
    this.schoolId,
    this.image,
    this.address,
  });

  @override
  List<Object> get props => [
        name!,
        email!,
        password!,
        confirmPassword!,
        mobile!,
        sectionId!,
        schoolId!
      ];
}
