class Article {
  final String title;
  final String imageUrl;
  final String sourceName;
  final DateTime publishedAt;
  final String author;
  final String content;
  final String url;

  Article({
    required this.title,
    required this.imageUrl,
    required this.sourceName,
    required this.publishedAt,
    required this.author,
    required this.content,
    required this.url,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'],
      imageUrl: json['urlToImage'] ?? '',
      sourceName: json['source']['name'],
      publishedAt: DateTime.parse(json['publishedAt']),
      author: json['author'] ?? 'Unknown',
      content: json['content'] ?? '',
      url: json['url'],
    );
  }
}