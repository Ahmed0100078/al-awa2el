import 'dart:io';
import 'package:equatable/equatable.dart';

class EditProfileEntity extends Equatable {
  final String name, phone, email;
  final File image;

  const EditProfileEntity({
    required this.name,
    required this.phone,
    required this.email,
    required this.image,
  });

  @override
  List<Object> get props => [name, phone, email, image];
}
