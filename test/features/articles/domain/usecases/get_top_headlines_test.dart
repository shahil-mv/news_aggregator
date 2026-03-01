import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_aggregator/core/error/failures.dart';
import 'package:news_aggregator/features/articles/domain/entities/article.dart';
import 'package:news_aggregator/features/articles/domain/repositories/news_repository.dart';
import 'package:news_aggregator/features/articles/domain/usecases/get_top_headlines.dart';

class MockArticleRepository extends Mock implements ArticleRepository {}

void main() {
  late GetTopHeadlines usecase;
  late MockArticleRepository mockArticleRepository;

  setUp(() {
    mockArticleRepository = MockArticleRepository();
    usecase = GetTopHeadlines(mockArticleRepository);
  });

  final tArticles = [
    const Article(
      title: 'Test Title',
      description: 'Test Description',
      url: 'https://test.com',
      urlToImage: 'https://test.com/image.jpg',
      content: 'Test Content',
    ),
  ];

  test('should get top headlines from the repository', () async {
    // arrange
    when(
      () => mockArticleRepository.getTopHeadlines(),
    ).thenAnswer((_) async => Right(tArticles));
    // act
    final result = await usecase();
    // assert
    expect(result, Right(tArticles));
    verify(() => mockArticleRepository.getTopHeadlines());
    verifyNoMoreInteractions(mockArticleRepository);
  });

  test('should return ServerFailure when the repository fails', () async {
    // arrange
    when(
      () => mockArticleRepository.getTopHeadlines(),
    ).thenAnswer((_) async => const Left(ServerFailure()));
    // act
    final result = await usecase();
    // assert
    expect(result, const Left(ServerFailure()));
    verify(() => mockArticleRepository.getTopHeadlines());
    verifyNoMoreInteractions(mockArticleRepository);
  });
}
