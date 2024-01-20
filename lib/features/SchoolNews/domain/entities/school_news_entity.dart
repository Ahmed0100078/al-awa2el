import 'package:equatable/equatable.dart';
import 'package:madaresco/features/SchoolNews/data/models/school_news_model.dart';

// ignore: must_be_immutable
class SchoolNewsEntity extends Equatable {
  final List<NewsEntity> news;
  String next;

  SchoolNewsEntity({required this.news, required this.next});

  @override
  List<Object> get props => [news];
}

class NewsEntity extends Equatable {
  final String image, date, title, description;
  final int number, id;
  final List<Album> photos;

  const NewsEntity(
      {required this.image,
      required this.date,
      required this.title,
      required this.description,
      required this.number,
      required this.id,
      required this.photos});

  @override
  List<Object> get props =>
      [image, date, title, description, number, id, photos];
}
