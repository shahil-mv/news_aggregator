import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../features/articles/data/models/news_api_response.dart';

part 'news_api_service.g.dart';

@RestApi(baseUrl: "https://api.spaceflightnewsapi.net/v4/")
abstract class ArticleApiService {
  factory ArticleApiService(Dio dio, {String baseUrl}) = _ArticleApiService;

  @GET("articles/")
  Future<ArticleApiResponse> getTopHeadlines({
    @Query("limit") int limit = 10,
    @Query("offset") int offset = 0,
  });
}
