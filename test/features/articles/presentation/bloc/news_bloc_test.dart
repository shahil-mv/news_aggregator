import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_aggregator/core/error/failures.dart';
import 'package:news_aggregator/features/articles/domain/entities/article.dart';
import 'package:news_aggregator/features/articles/domain/usecases/get_top_headlines.dart';
import 'package:news_aggregator/features/articles/presentation/bloc/news_bloc.dart';
import 'package:news_aggregator/features/articles/presentation/bloc/news_event.dart';
import 'package:news_aggregator/features/articles/presentation/bloc/news_state.dart';

class MockGetTopHeadlines extends Mock implements GetTopHeadlines {}

void main() {
  late ArticlesBloc bloc;
  late MockGetTopHeadlines mockGetTopHeadlines;

  setUp(() {
    mockGetTopHeadlines = MockGetTopHeadlines();
    bloc = ArticlesBloc(getTopHeadlines: mockGetTopHeadlines);
  });

  const tArticle = Article(
    title: 'Test Title',
    description: 'Test Description',
    url: 'https://test.com',
    urlToImage: 'https://test.com/image.jpg',
    content: 'Test Content',
  );

  final tArticles = [tArticle];

  test('initial state should be ArticlesInitial', () {
    expect(bloc.state, equals(ArticlesInitial()));
  });

  group('GetTopHeadlinesEvent', () {
    blocTest<ArticlesBloc, ArticlesState>(
      'should emit [ArticlesLoading, ArticlesLoaded] when data is gotten successfully',
      build: () {
        when(
          () => mockGetTopHeadlines(),
        ).thenAnswer((_) async => Right(tArticles));
        return bloc;
      },
      act: (bloc) => bloc.add(GetTopHeadlinesEvent()),
      expect: () => [ArticlesLoading(), ArticlesLoaded(tArticles)],
      verify: (_) {
        verify(() => mockGetTopHeadlines());
      },
    );

    blocTest<ArticlesBloc, ArticlesState>(
      'should emit [ArticlesLoading, ArticlesError] when getting data fails',
      build: () {
        when(
          () => mockGetTopHeadlines(),
        ).thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (bloc) => bloc.add(GetTopHeadlinesEvent()),
      expect: () => [ArticlesLoading(), const ArticlesError('Server Failure')],
      verify: (_) {
        verify(() => mockGetTopHeadlines());
      },
    );
  });
}
