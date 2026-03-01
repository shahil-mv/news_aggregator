import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_aggregator/features/articles/domain/usecases/get_top_headlines.dart';
import 'news_event.dart';
import 'news_state.dart';

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  final GetTopHeadlines getTopHeadlines;

  ArticlesBloc({required this.getTopHeadlines}) : super(ArticlesInitial()) {
    on<GetTopHeadlinesEvent>((event, emit) async {
      emit(ArticlesLoading());
      final result = await getTopHeadlines();
      result.fold(
        (failure) => emit(ArticlesError(failure.message)),
        (articles) => emit(ArticlesLoaded(articles)),
      );
    });
  }
}
