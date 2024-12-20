import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import '../../config.dart';
import 'api_path.dart';

class ApiService {
  static Future<List<Map<String, dynamic>>> getTopHeadlines(
      {required String country}) async {
    String endPoint =
        ApiPath.newsApi(NewsFeedEndpoint.topHeadlines, country: country);

    final response = await http.get(
      Uri.parse(endPoint),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<Map<String, dynamic>> articles =
          List<Map<String, dynamic>>.from(data['articles']);
      return articles;
    } else {
      throw Exception('Failed to load top headlines');
    }
  }

  static Future<List<Map<String, dynamic>>> getEverything() async {
    final response = await http.get(
      Uri.parse(ApiPath.tesla_News),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<Map<String, dynamic>> articles =
          List<Map<String, dynamic>>.from(data['articles']);
      return articles;
    } else {
      throw Exception('Failed to load top headlines');
    }
  }

  static Future<List<Map<String, dynamic>>> searchKeyword(
      String? keyword) async {
    final Uri apiUrl = Uri(
      scheme: 'https',
      host: 'newsapi.org',
      path: '/v2/everything',
      queryParameters: {
        'q': keyword,
        'sortBy': 'publishedAt',
        'apiKey': Config.apiKey,
      },
    );

    log(apiUrl.toString());

    final response = await http.get(
      apiUrl,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<Map<String, dynamic>> articles =
          List<Map<String, dynamic>>.from(data['articles']);
      log(name: "SEARCH API RESPONSE", articles.toString());
      return articles;
    } else {
      throw Exception('Failed to load top headlines');
    }
  }
}
