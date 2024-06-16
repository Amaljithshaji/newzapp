// lib/models/article_model.dart
import 'package:hive/hive.dart';

import 'article.dart';
part 'article_model.g.dart';

@HiveType(typeId: 0)
class ArticleModel {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String imageUrl;

  @HiveField(2)
  final String sourceName;

  @HiveField(3)
  final DateTime publishedAt;

  @HiveField(4)
  final String author;

  @HiveField(5)
  final String content;

  @HiveField(6)
  final String url;

  ArticleModel({
    required this.title,
    required this.imageUrl,
    required this.sourceName,
    required this.publishedAt,
    required this.author,
    required this.content,
    required this.url,
  });

  factory ArticleModel.fromArticle(Article article) {
    return ArticleModel(
      title: article.title,
      imageUrl: article.imageUrl,
      sourceName: article.sourceName,
      publishedAt: article.publishedAt,
      author: article.author,
      content: article.content,
      url: article.url,
    );
  }
   Article toArticle() {
    return Article(
      title: title,
      imageUrl: imageUrl,
      sourceName: sourceName,
      publishedAt: publishedAt,
      author: author,
      content: content,
      url: url,
    );
  }
}
