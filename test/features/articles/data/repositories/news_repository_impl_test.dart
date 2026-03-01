import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_aggregator/core/error/failures.dart';
import 'package:news_aggregator/features/articles/data/datasources/news_remote_data_source.dart';
import 'package:news_aggregator/features/articles/data/models/article_model.dart';
import 'package:news_aggregator/features/articles/data/repositories/news_repository_impl.dart';

class MockRemoteDataSource extends Mock implements ArticleRemoteDataSource {}

void main() {
  late ArticleRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    repository = ArticleRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  const tArticleModel = ArticleModel(
    title: 'Test Title',
    description: 'Test Description',
    url: 'https://test.com',
    urlToImage: 'https://test.com/image.jpg',
    content: 'Test Content',
  );

  final tArticles = [tArticleModel];

  group('getTopHeadlines', () {
    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        // arrange
        when(
          () => mockRemoteDataSource.getTopHeadlines(),
        ).thenAnswer((_) async => tArticles);
        // act
        final result = await repository.getTopHeadlines();
        // assert
        verify(() => mockRemoteDataSource.getTopHeadlines());
        expect(result, equals(Right(tArticles)));
      },
    );

    test(
      'should return server failure when the call to remote data source is unsuccessful',
      () async {
        // arrange
        when(
          () => mockRemoteDataSource.getTopHeadlines(),
        ).thenThrow(Exception());
        // act
        final result = await repository.getTopHeadlines();
        // assert
        verify(() => mockRemoteDataSource.getTopHeadlines());
        expect(
          result,
          equals(const Left(ServerFailure('An error occurred on the server'))),
        );
      },
    );
  });
}
