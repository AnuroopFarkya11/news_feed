
import 'package:com.newsfeed.app/blocs/favTabBloc.dart';
import 'package:com.newsfeed.app/blocs/hmmBloc.dart';
import 'package:com.newsfeed.app/firebase_options.dart';
import 'package:com.newsfeed.app/routes/route_path.dart';
import 'package:com.newsfeed.app/routes/route_service.dart';
import 'package:com.newsfeed.app/screens/auth/login/login_screen.dart';
import 'package:com.newsfeed.app/screens/auth/mainpage.dart';
import 'package:com.newsfeed.app/services/database/sql_base.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:com.newsfeed.app/blocs/searchBloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'blocs/NewsBloc.dart';
import 'screens/onboarding/screens/onboding/onboding_screen.dart';
//com.android.application
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
              BlocProvider<FavouriteBloc>(create: (context)=>FavouriteBloc()),
              BlocProvider<ReelBloc>(create: (context)=>ReelBloc(AsyncSnapshot.nothing()))
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                useMaterial3: true,
                brightness: Brightness.light,
                fontFamily:GoogleFonts.libreFranklin().fontFamily

              ),
              darkTheme: ThemeData(
                useMaterial3: true,
                brightness: Brightness.dark,
                fontFamily: GoogleFonts.libreFranklin().fontFamily
              ),
              themeMode: ThemeMode.system,
              // home: OnboardingScreen(),
              initialRoute: RoutePath.root,
              routes: RouteService.routes,
            ),
          )),

    );
  }
}
