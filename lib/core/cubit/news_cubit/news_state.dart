part of 'news_cubit.dart';

abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoadingState extends NewsState {}

class NewsLoadingMoreState extends NewsState {}

class NewsLoadingPreviousState extends NewsState {}

class NewsSuccessState extends NewsState {
  final List<Article> news;
  final bool isRefresh;
  final bool hasMore;

  NewsSuccessState({required this.news, this.isRefresh = false, this.hasMore = true});
}

class NewsPreviousPageState extends NewsState {
  final List<Article> news;

  NewsPreviousPageState({required this.news});
}

class NewsErrorState extends NewsState {
  final String error;

  NewsErrorState({required this.error});
}