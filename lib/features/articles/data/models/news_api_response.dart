import 'article_model.dart';

class ArticleApiResponse {
  final List<ArticleModel> articles;

  ArticleApiResponse({required this.articles});

  factory ArticleApiResponse.fromJson(Map<String, dynamic> json) {
    // The SpaceFlight News API uses 'results' as the key for the news articles list.
    // We map it to 'articles' internally to stay consistent with our domain.
    return ArticleApiResponse(
      articles: (json['results'] as List)
          .map((i) => ArticleModel.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
  }
}
