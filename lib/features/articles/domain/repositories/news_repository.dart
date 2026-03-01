import 'package:dartz/dartz.dart';
import 'package:news_aggregator/core/error/failures.dart';
import '../entities/article.dart';

abstract class ArticleRepository {
  Future<Either<Failure, List<Article>>> getTopHeadlines();
}
