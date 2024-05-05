import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com.newsfeed.app/constants/brand_style_constants.dart';
import 'package:com.newsfeed.app/constants/brand_color_constants.dart';
import 'package:com.newsfeed.app/constants/brand_text_constants.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../blocs/NewsBloc.dart';
import '../../../models/article_model.dart';
import '../../../widgets/news_card.dart';
import '../../news/news_screen.dart';
import '../../../widgets/breaking_news_card.dart';


Stream? stream;
class HomeScreenTab extends StatefulWidget {
  const HomeScreenTab({Key? key}) : super(key: key);

  @override
  State<HomeScreenTab> createState() => _HomeScreenTabState();
}

class _HomeScreenTabState extends State<HomeScreenTab> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late PageController _pageController;
  late final NewsBloc newsBloc;
  final ScrollController scrollController = ScrollController();
  bool viewBool = false;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    newsBloc = BlocProvider.of<NewsBloc>(context);
    newsBloc.getHeadlineNews();

    _pageController =
        PageController(initialPage: 0, viewportFraction: 0.95, keepPage: true);




  }

  @override
  Widget build(BuildContext context) {



    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///    BREAKING NEWS AND VIEW ALL
          Container(
              margin: EdgeInsets.symmetric(vertical: 0.h, horizontal: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(BrandTextConstant.homeTitle,
                      style: BrandTextStyle.title),
                  Text(
                    BrandTextConstant.viewAll,
                    style: BrandTextStyle.body15!.copyWith(height: 4),
                  )
                ],
              )),

          /// PAGE VIEWERS
          Container(
              height: 200.h,
              child: BlocBuilder<NewsBloc, List<Article>>(
                builder: (context, articles) {
                  bool isShimmer = articles.length == 0;
                  return PageView.builder(
                    clipBehavior: Clip.antiAlias,
                    itemCount: isShimmer ? 5 : 5,
                    controller: _pageController,
                    allowImplicitScrolling: true,
                    pageSnapping: true,
                    onPageChanged: (value) {
                      setState(() {
                        currentIndex = value;
                      });
                    },
                    itemBuilder: (context, index) {
                      var article;
                      if (!isShimmer) {
                        article = articles[index];
                      }
                      return isShimmer
                          ? BreakingNewsCard.shimmerCard()
                          : BreakingNewsCard(
                              article: article,
                            );
                    },
                  );
                },
              )),
          SizedBox(
            height: 10,
          ),
          Center(
            child: DotsIndicator(
              mainAxisSize: MainAxisSize.min,
              dotsCount: 5,
              mainAxisAlignment: MainAxisAlignment.center,
              position: currentIndex.toDouble(),
              decorator: DotsDecorator(
                activeColor: BrandColors.brandColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
                activeShape: StadiumBorder(
                  side: BorderSide.none,
                ),
              ),
              onTap: (val) {
                _pageController.animateToPage(val.toInt(),
                    duration: Duration(milliseconds: 500),
                    curve: Curves.linear);
              },
            ),
          ),

          Container(
              margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    BrandTextConstant.recommendation,
                    style: BrandTextStyle.title,
                  ),
                  Visibility(
                    visible: false,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          viewBool = true;
                          scrollController.animateTo(200.h,
                              duration: Duration(milliseconds: 200),
                              curve: Curves.easeIn);
                        });
                      },
                      child: Text(
                        BrandTextConstant.viewAll,
                        style: BrandTextStyle.body15!.copyWith(height: 4),
                      ),
                    ),
                  )
                ],
              )),

          BlocBuilder<NewsBloc, List<Article>>(builder: (context, articles) {
            return ListView.builder(
                controller: scrollController,
                shrinkWrap: true,
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  final article = articles[index];
                  return NewsCard(
                    article: article,
                  );
                });
          })
        ],
      ),
    );
  }
}
