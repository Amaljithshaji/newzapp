part of 'search_cubit.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchSuccessState extends SearchState {
  final List<Article> news;


  SearchSuccessState({required this.news,});
}

class SearchErrorState extends SearchState {
  final String error;

  SearchErrorState({required this.error});
}