import 'package:bloc/bloc.dart';
import 'package:siyatech/models/article_model.dart';

import '../services/api/api_service.dart';

class SearchBloc extends Cubit<List<Article>>{
  SearchBloc() : super([]);


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