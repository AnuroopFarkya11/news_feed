import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'api_path.dart';

class ApiService{


  static Future<List<Map<String, dynamic>>> getTopHeadlines() async {
    final response = await http.get(
      Uri.parse(ApiPath.TopHeadlines),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<Map<String, dynamic>> articles = List<Map<String, dynamic>>.from(data['articles']);
      return articles;
    } else {
      throw Exception('Failed to load top headlines');
    }
  }
}






/*
*
*
*
*
*
* */