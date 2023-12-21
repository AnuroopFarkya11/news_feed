import 'article_model.dart';

class NewsModel {
  final String status;
  final int totalResults;
  final List<Article> articles;

  NewsModel({required this.status, required this.totalResults, required this.articles});

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      status: json['status'],
      totalResults: json['totalResults'],
      articles: List<Article>.from(json['articles'].map((article) => Article.fromJson(article))),
    );
  }
}
