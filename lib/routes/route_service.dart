import 'package:com.newsfeed.app/routes/route_path.dart';
import 'package:com.newsfeed.app/screens/add_news/add_news_screen.dart';
import 'package:com.newsfeed.app/screens/auth/mainpage.dart';
import 'package:com.newsfeed.app/screens/custom_news/custom_news_screen.dart';
import 'package:com.newsfeed.app/screens/dashboard/dash_board.dart';
import 'package:com.newsfeed.app/screens/news/news_screen.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class RouteService{

  static Map<String,WidgetBuilder> routes = {
    RoutePath.root: (context) => const LandingPage(),
    RoutePath.newsScreen: (context) => NewsPage(),
    RoutePath.addNewsPage :(context)=> AddNewsPage(),
    RoutePath.customNews :(context)=> CustomNews(),
  };



}