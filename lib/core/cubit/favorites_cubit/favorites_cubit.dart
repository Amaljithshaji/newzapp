import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';


import '../../models/article_model.dart';
import 'package:crypto/crypto.dart';
part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final Box<ArticleModel> _favoritesBox;

  FavoritesCubit(this._favoritesBox) : super(FavoritesInitial());

   String _generateKey(String url) {
    // Use SHA256 to generate a short, unique key from the URL
    return sha256.convert(utf8.encode(url)).toString();
  }

  void loadFavorites() {
    emit(FavoritesLoading());
    try {
      final favorites = _favoritesBox.values.toList();
     
      emit(FavoritesLoaded(favorites));
    } catch (e) {
      emit(FavoritesError('Failed to load favorites'));
    }
  }

  void addFavorite(ArticleModel article) {
     final key = _generateKey(article.url);
    _favoritesBox.put(key, article);
    print(_favoritesBox.get(key));
    loadFavorites();
  }

  void removeFavorite(ArticleModel article) {
     final key = _generateKey(article.url);
    _favoritesBox.delete(key);
    loadFavorites();
  }

   bool isFavorite(String url) {
    final key = _generateKey(url);
    return _favoritesBox.containsKey(key);
  }

   ArticleModel? getFavorite(String url) {
    final key = _generateKey(url);
    return _favoritesBox.get(key);
  }
}
