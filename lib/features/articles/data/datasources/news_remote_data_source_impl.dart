import '../models/article_model.dart';
import '../../../../core/network/news_api_service.dart';
import 'news_remote_data_source.dart';

class ArticleRemoteDataSourceImpl implements ArticleRemoteDataSource {
  final ArticleApiService apiService;

  ArticleRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<ArticleModel>> getTopHeadlines() async {
    // Current SpaceFlight News API (v4) needs no credentials.
    final response = await apiService.getTopHeadlines();
    return response.articles;
  }
}
