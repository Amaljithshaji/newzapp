import 'package:bloc/bloc.dart';
import 'package:newzapp/core/repo/getnews_repo.dart';

import '../../models/article.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final NewsRepo repo;
  int currentPage = 1;
  bool isFetching = false;
  bool hasMore = true;

  NewsCubit({required this.repo}) : super(NewsInitial());

  getNews({required String category}) async {
    if (isFetching) return;

    currentPage = 1;
    hasMore = true;
    isFetching = true;

    emit(NewsLoadingState());

    try {
      final news = await repo.getNews(category: category, page: currentPage);
      if (news.isEmpty) {
        hasMore = false;
      }
      emit(NewsSuccessState(news: news, isRefresh: true, hasMore: hasMore));
      print(currentPage);
    } catch (e) {
      emit(NewsErrorState(error: e.toString()));
    } finally {
      isFetching = false;
    }
  }

  loadMore({required String category}) async {
    if (isFetching || !hasMore) return;

    isFetching = true;
    emit(NewsLoadingMoreState());

    try {
      final news = await repo.getNews(category: category, page: currentPage);
      if (news.isEmpty) {
        hasMore = false;
      }
      emit(NewsSuccessState(news: news, hasMore: hasMore));
      currentPage++;
      print(currentPage);
   
    } catch (e) {
      emit(NewsErrorState(error: e.toString()));
    } finally {
      isFetching = false;
    }
  }

  loadPrevious({required String category}) async {
    if (isFetching) return;

    isFetching = true;
    emit(NewsLoadingPreviousState());

    try {
      final news = await repo.getNews(category: category, page: currentPage - 2);
      emit(NewsPreviousPageState(news: news));
    } catch (e) {
      emit(NewsErrorState(error: e.toString()));
    } finally {
      isFetching = false;
    }
  }
}