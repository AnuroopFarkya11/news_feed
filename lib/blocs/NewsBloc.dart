import 'dart:developer';

import 'package:bloc/bloc.dart';
import '../models/article_model.dart';
import '../services/api/api_service.dart';

class NewsBloc extends Cubit<List<Article>> {
  NewsBloc() : super([]);

  Future<void> getHeadlineNews() async {
    try {
      final List<Map<String, dynamic>> articles =
          await ApiService.getTopHeadlines();

      final List<Article> articleObjects =
          articles.map((article) => Article.fromJson(article)).toList();
      log(articleObjects.toString());
      emit(articleObjects);
    } catch (error) {
      // Handle errors
      print('Error: $error');
    }
  }
  Future<void> getEveryNews() async {
    try {
      final List<Map<String, dynamic>> articles =
      await ApiService.getEverything();

      final List<Article> articleObjects =
      articles.map((article) => Article.fromJson(article)).toList();
      log(articleObjects.toString());
      emit(articleObjects);
    } catch (error) {
      // Handle errors
      print('Error: $error');
    }
  }

  Future<void> searchKeyword(String? keyword) async {
    try {
      final List<Map<String, dynamic>> articles =
      await ApiService.searchKeyword(keyword);
      final List<Article> articleObjects =
      articles.map((article) => Article.fromJson(article)).toList();
      // log(articleObjects.toString());
      emit(articleObjects);
    } catch (error) {
      // Handle errors
      print('Error: $error');
    }
  }
}
