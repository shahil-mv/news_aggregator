import 'package:dartz/dartz.dart';
import 'package:news_aggregator/core/error/failures.dart';
import '../entities/article.dart';
import '../repositories/news_repository.dart';

class GetTopHeadlines {
  final ArticleRepository repository;

  GetTopHeadlines(this.repository);

  Future<Either<Failure, List<Article>>> call() async {
    return await repository.getTopHeadlines();
  }
}
