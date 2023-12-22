

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:siyatech/screens/search/search_screen.dart';

import '../../../blocs/NewsBloc.dart';
import '../../../models/article_model.dart';
import '../../../widgets/app_icon.dart';
import '../../../widgets/news_card.dart';
import '../../news/news_screen.dart';
import '../../../widgets/breaking_news_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final NewsBloc newsBloc;

  @override
  void initState() {
    super.initState();
    newsBloc = BlocProvider.of<NewsBloc>(context);
    newsBloc.getHeadlineNews();
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Home',
      style: optionStyle,
    ),
    Text(
      'Likes',
      style: optionStyle,
    ),
    Text(
      'Search',
      style: optionStyle,
    ),
    Text(
      'Profile',
      style: optionStyle,
    ),
  ];

  onSearchTap() {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InterfaceIcon(
          icon: Icons.menu,
          onTap: () {},
        ),
        actions: [

          InterfaceIcon(icon: Icons.search, onTap: onSearchTap),
          // InterfaceIcon(icon: Icons.search, onTap: onSearchTap),
          InterfaceIcon(icon: Icons.notification_important, onTap: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///    BREAKING NEWS AND VIEW ALL
            Container(
                margin: EdgeInsets.symmetric(vertical: 7.h, horizontal: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Breaking News",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 25.sp,
                          textBaseline: TextBaseline.alphabetic),
                    ),
                    Text(
                      "View all",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 15.sp,
                        height: 4,
                        textBaseline: TextBaseline.alphabetic,
                      ),
                    )
                  ],
                )),

            /// PAGE VIEWERS
            Container(
              height: 170.h,
              child: PageView.builder(
                  itemCount: 5,
                  controller: PageController(
                    initialPage: 2,
                    viewportFraction: 0.95,
                  ),
                  itemBuilder: (context, index) {
                    return BlocBuilder<NewsBloc, List<Article>>(
                      builder: (context, articles) {
                        return PageView.builder(
                          itemCount: articles.length,
                          itemBuilder: (context, index) {
                            final article = articles[index];
                            return GestureDetector(
                                onTap: () {
                                  // Navigator.pushNamed(context,'/news',);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              NewsPage(
                                                article: article,
                                              )));
                                },
                                child: BreakingNewsCard(
                                  article: article,
                                ));
                          },
                        );
                      },
                    );
                  }),
            ),
            SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              DotsIndicator(
                dotsCount: 5,

                /// item list
                position: 3,
                decorator: DotsDecorator(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  activeShape: StadiumBorder(side: BorderSide()),
                ),
              )
            ]),

            SizedBox(
              height: 10,
            ),

            Container(
                margin: EdgeInsets.symmetric(vertical: 7.h, horizontal: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Recommendation",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 25.sp,
                          textBaseline: TextBaseline.alphabetic),
                    ),
                    Text(
                      "View all",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 15.sp,
                        height: 4,
                        textBaseline: TextBaseline.alphabetic,
                      ),
                    )
                  ],
                )),



            Container(
              height: 500.h,
              child: BlocBuilder<NewsBloc,List<Article>>(builder:(context, articles){
                return ListView.builder(
                            shrinkWrap: true,
                            itemCount: articles.length,
                            itemBuilder: (context, index) {
                              final article = articles[index];
                              return GestureDetector(onTap:(){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NewsPage(article: article,)));
                              },child: NewsCard(article:article,));
                            });
              }),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.blue,
              color: Colors.black,
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.ac_unit_rounded,
                  text: 'Likes',
                ),
                GButton(
                  icon: Icons.save,
                  text: 'Search',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
