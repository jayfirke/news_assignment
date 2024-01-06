import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_assignment/Model/news.dart';

class NewsService {
  final String apiKey = '874d287c1df24b139d47fdbfaa0446e1'; // by using env plugin we can put api keys in ENV file for security purposes

  Future<List<News>> getNews() async {
    final response = await http.get(Uri.parse('https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> articles = data['articles'];
      return articles.map((article) => News(
        sourceName: article['source']['name'] ?? "No Name from API",
        title: article['title'] ?? "No Title from API",
        description: article['description'] ?? "No description from API",
        url: article['url'] ?? "https://newsapi.org",
        imageUrl: article['urlToImage'] ?? "https://media.istockphoto.com/id/1215475499/photo/online-news-on-a-smartphone-woman-reading-news-or-articles-in-a-mobile-phone-screen.jpg?s=612x612&w=0&k=20&c=W4-Fczhlw8pf25sg5XruTg2oKpTwu7Lo7ZgYroOzT7U=",
        publishedAt: article['publishedAt'] ?? "No time specified",
      )).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }

}
