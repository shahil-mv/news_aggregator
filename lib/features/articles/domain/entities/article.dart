import 'package:equatable/equatable.dart';

class Article extends Equatable {
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String content;

  const Article({
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.content,
  });

  @override
  List<Object?> get props => [title, description, url, urlToImage, content];
}
