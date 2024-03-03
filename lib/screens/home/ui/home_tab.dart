import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../blocs/NewsBloc.dart';
import '../../../models/article_model.dart';
import '../../../widgets/news_card.dart';
import '../../news/news_screen.dart';
import '../../../widgets/breaking_news_card.dart';

class HomeScreenTab extends StatefulWidget {
  const HomeScreenTab({Key? key}) : super(key: key);

  @override
  State<HomeScreenTab> createState() => _HomeScreenTabState();
}

class _HomeScreenTabState extends State<HomeScreenTab> {
  PageController _pageController =
      PageController(initialPage: 2, viewportFraction: 0.95, keepPage: true);
  late final NewsBloc newsBloc;
  final ScrollController scrollController = ScrollController();
  bool viewBool = false;

  @override
  void initState() {
    super.initState();
    newsBloc = BlocProvider.of<NewsBloc>(context);
    newsBloc.getHeadlineNews();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        controller: scrollController,
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
                child: BlocBuilder<NewsBloc, List<Article>>(
                  builder: (context, articles) {
                    return PageView.builder(
                      clipBehavior: Clip.antiAlias,
                      itemCount: articles.length,
                      controller: _pageController,
                      allowImplicitScrolling: true,
                      pageSnapping: true,
                      itemBuilder: (context, index) {
                        final article = articles[index];
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NewsPage(
                                            article: article,
                                          )));
                            },
                            child: BreakingNewsCard(
                              article: article,
                            ));
                      },
                    );
                  },
                )),
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
                  activeShape: StadiumBorder(side: BorderSide(),
                  ),
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
                    InkWell(
                      onTap: () {
                        setState(() {
                          viewBool = true;
                          scrollController.animateTo(200.h,
                              duration: Duration(seconds: 1),
                              curve: Curves.easeIn);
                        });
                      },
                      child: Text(
                        "View all",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 15.sp,
                          height: 4,
                          textBaseline: TextBaseline.alphabetic,
                        ),
                      ),
                    )
                  ],
                )),

            Container(
              height: viewBool ? 450.h : 200.h,
              child: BlocBuilder<NewsBloc, List<Article>>(
                  builder: (context, articles) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      final article = articles[index];
                      return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => NewsPage(
                                      article: article,
                                    )));
                          },
                          child: NewsCard(
                            article: article,
                          ));
                    });
              }),
            )
          ],
        ),
      ),
    );
  }
}
