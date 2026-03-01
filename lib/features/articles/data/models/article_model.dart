import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/article.dart';

part 'article_model.g.dart';

@JsonSerializable()
class ArticleModel extends Article {
  const ArticleModel({
    required super.title,
    required super.description,
    required super.url,
    required super.urlToImage,
    required super.content,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    // SpaceFlight News API (SFNA) maps to our entity structure:
    // title -> title
    // summary -> description / content
    // url -> url
    // image_url -> urlToImage
    final map = Map<String, dynamic>.from(json);

    // Map SFNA 'summary' to our 'description' and 'content' since they serve the same purpose.
    if (map.containsKey('summary')) {
      map['description'] = map['summary'] ?? '';
      map['content'] = map['summary'] ?? '';
    }

    // Map SFNA 'image_url' to our 'urlToImage'.
    if (map.containsKey('image_url')) {
      map['urlToImage'] = map['image_url'] ?? '';
    }

    // Default values if missing
    map['description'] ??= '';
    map['content'] ??= '';
    map['urlToImage'] ??= '';

    return _$ArticleModelFromJson(map);
  }

  Map<String, dynamic> toJson() {
    final map = _$ArticleModelToJson(this);
    // Back-mapping if we ever need to send it back to the same API
    map['summary'] = map['description'];
    map['image_url'] = map['urlToImage'];
    return map;
  }
}
