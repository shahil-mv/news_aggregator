import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:news_aggregator/core/network/news_api_service.dart';
import 'package:news_aggregator/features/articles/data/datasources/news_remote_data_source.dart';
import 'package:news_aggregator/features/articles/data/datasources/news_remote_data_source_impl.dart';
import 'package:news_aggregator/features/articles/data/repositories/news_repository_impl.dart';
import 'package:news_aggregator/features/articles/domain/repositories/news_repository.dart';
import 'package:news_aggregator/features/articles/domain/usecases/get_top_headlines.dart';
import 'package:news_aggregator/features/articles/presentation/bloc/news_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Blocs
  sl.registerFactory(() => ArticlesBloc(getTopHeadlines: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetTopHeadlines(sl()));

  // Repositories
  sl.registerLazySingleton<ArticleRepository>(
    () => ArticleRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<ArticleRemoteDataSource>(
    () => ArticleRemoteDataSourceImpl(apiService: sl()),
  );

  // External
  final dio = Dio();
  // Add professional logging interceptors
  dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

  sl.registerLazySingleton(() => dio);
  sl.registerLazySingleton(() => ArticleApiService(dio));
}
