
import 'package:NewsFeed/blocs/favTabBloc.dart';
import 'package:NewsFeed/routes/route_service.dart';
import 'package:NewsFeed/services/database/sql_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:NewsFeed/blocs/searchBloc.dart';
import 'blocs/NewsBloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await DBBase.db;
  runApp(const NewsApp());
}

class NewsApp extends StatefulWidget {
  const NewsApp({Key? key}) : super(key: key);

  @override
  State<NewsApp> createState() => _MyappState();
}

class _MyappState extends State<NewsApp> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constraint)=> ScreenUtilInit(
          designSize: Size(constraint.maxWidth,constraint.maxHeight),
          builder: (context, widget) => MultiBlocProvider(
            providers: [
              BlocProvider<NewsBloc>(create: (context) => NewsBloc()),
              BlocProvider<SearchBloc>(create: (context) => SearchBloc()),
              BlocProvider<FavouriteBloc>(create: (context)=>FavouriteBloc())
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(),
              initialRoute: '/',
              routes: RouteService.routes,
            ),
          )),

    );
  }
}
