import '../../config.dart';

class ApiPath{
  static String tesla_News = "https://newsapi.org/v2/everything?q=tesla&from=2023-11-21&sortBy=publishedAt&apiKey=9e872ae5f16345cc893337e0fc382b13";
  static String TopHeadlines= "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=${Config.apiKey}";
}