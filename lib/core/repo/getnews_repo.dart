

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/article.dart';

class NewsRepo{
  final  String apiKey = '5c544eb5316e4b0780f752c2c50455e3'; //5369166f8a8243db9cb01c749e06adaa
  final String baseUrl = 'https://newsapi.org/v2';
   Future<List<Article>> getNews({required String category,required int page}) async {
    
    try{
    final response = await http.get(Uri.parse('$baseUrl/top-headlines?country=in&category=$category&apiKey=$apiKey&page=$page'));
    

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> articlesJson = data['articles'];
      return articlesJson.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load articles');
    }     
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }
}