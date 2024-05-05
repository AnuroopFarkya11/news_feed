import 'package:com.newsfeed.app/models/article_model.dart';
import 'package:com.newsfeed.app/services/database/sql_base.dart';
import 'package:bloc/bloc.dart';

class FavouriteBloc extends Cubit<List<Article>>{
  FavouriteBloc() : super([]);

  Future<void> getFavouriteList()async{
    print("getFavouriteList called");
    try{
      final List<Map<String,dynamic>> data = await DBBase.queryAllLikedNews();
      List<Article> favArticleList = data
          .map((Map<String, dynamic> e) => Article.fromJson(e))
          .toList();

      print("getFavouriteList $favArticleList");
      emit(favArticleList);
    }
    on Exception catch(e){
      rethrow;
    }
  }
}