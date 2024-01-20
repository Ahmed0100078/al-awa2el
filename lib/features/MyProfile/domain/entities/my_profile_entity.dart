import 'package:equatable/equatable.dart';

class MyProfileEntity extends Equatable {
  final String name, image, phone, email;

  const MyProfileEntity({
    required this.name,
    required this.image,
    required this.phone,
    required this.email,
  });

  @override
  List<Object> get props => [name, image, phone, email];
}
