import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:siyatech/screens/home/ui/home_screen.dart';
import 'package:siyatech/screens/news/news_screen.dart';
import 'package:siyatech/screens/search/search_screen.dart';
import 'blocs/NewsBloc.dart';

void main() async {
  await dotenv.load();
  runApp(NewsApp());
}

class NewsApp extends StatefulWidget {
  const NewsApp({Key? key}) : super(key: key);

  @override
  State<NewsApp> createState() => _MyappState();
}

class _MyappState extends State<NewsApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        builder: (context, widget) => MultiBlocProvider(
              providers: [
                BlocProvider<NewsBloc>(create: (context) => NewsBloc()),
              ],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(),
                initialRoute: '/',
                routes: {
                  '/': (context) => HomeScreen(),
                  '/search': (context) => SearchScreen(),
                  '/news': (context) => NewsPage()
                },
              ),
            ));
  }
}
