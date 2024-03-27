import 'package:NewsFeed/routes/route_path.dart';
import 'package:NewsFeed/screens/dashboard/dash_board.dart';
import 'package:NewsFeed/screens/news/news_screen.dart';
import 'package:flutter/material.dart';

class RouteService{

  static Map<String,WidgetBuilder> routes = {
    RoutePath.root: (context) => const DashBoard(),
    RoutePath.newsScreen: (context) => NewsPage()
  };



}