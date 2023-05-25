import 'dart:convert';

import 'package:http/http.dart' as http;

class NewsAPI {
  static const String baseUrl = 'https://newsapi.org/v2';
  static const String apiKey = 'e5b338a3337446c69de0a478c4373703';

  static Future<List<Article>> getBitcoinArticles() async {
    final url = Uri.parse('$baseUrl/everything?q=bitcoin&apiKey=$apiKey');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        if (data['status'] == 'ok') {
          final List<dynamic> articles = data['articles'];
          final List<Article> newsList =
              articles.map((article) => Article.fromJson(article)).toList();
          return newsList;
        } else {
          throw Exception('Failed to load news: ${data['message']}');
        }
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }
}

class Article {
  final Source source;
  final String author;
  final String title;
  final String description;

  Article({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      source: Source.fromJson(json['source']),
      author: json['author'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
    );
  }
}

class Source {
  final String id;
  final String name;

  Source({
    required this.id,
    required this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}
