import '../../config.dart';

class ApiPath{
  static String base_url = "https://newsapi.org/v2/everything";
  static String tesla_News = "$base_url?q=tesla&sortBy=publishedAt&apiKey=9e872ae5f16345cc893337e0fc382b13";
  static String TopHeadlines= "https://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=${Config.apiKey}";
}