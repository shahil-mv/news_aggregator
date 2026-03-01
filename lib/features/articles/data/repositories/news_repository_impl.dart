import 'package:dartz/dartz.dart';
import 'package:news_aggregator/core/error/failures.dart';
import 'package:news_aggregator/features/articles/domain/entities/article.dart';
import 'package:news_aggregator/features/articles/domain/repositories/news_repository.dart';
import 'package:news_aggregator/features/articles/data/datasources/news_remote_data_source.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleRemoteDataSource remoteDataSource;

  ArticleRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Article>>> getTopHeadlines() async {
    try {
      final remoteArticles = await remoteDataSource.getTopHeadlines();
      return Right(remoteArticles);
    } catch (e) {
      return const Left(ServerFailure('An error occurred on the server'));
    }
  }
}
