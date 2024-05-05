import 'dart:developer';
import 'package:com.newsfeed.app/constants/brand_asset_constants.dart';
import 'package:com.newsfeed.app/constants/brand_style_constants.dart';
import 'package:com.newsfeed.app/constants/brand_text_constants.dart';
import 'package:com.newsfeed.app/models/article_model.dart';
import 'package:com.newsfeed.app/routes/route_path.dart';
import 'package:com.newsfeed.app/services/database/sql_base.dart';
import 'package:com.newsfeed.app/widgets/app_icon.dart';
import 'package:com.newsfeed.app/widgets/news_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class CustomNews extends StatefulWidget {
  const CustomNews({super.key});

  @override
  State<CustomNews> createState() => _CustomNewsState();
}

class _CustomNewsState extends State<CustomNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  backgroundColor: Colors.transparent,
  elevation: 0,

  actions: [



    Builder(
      builder: (context) => InterfaceIcon(
          icon: Icons.notification_important,
          onTap: () {
            Scaffold.of(context).openEndDrawer();
          }),
    ),
  ],
),
      body:  SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                BrandTextConstant.publishedScreenTitle,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                    textBaseline: TextBaseline.alphabetic),
              ),
            ),
            Center(
              child: FutureBuilder(
                  future: DBBase.queryAllCustomNews(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        try {
                          if (snapshot.data!.length > 0) {
                            List<Article> list = snapshot.data!
                                .map((Map<String, dynamic> e) => Article.fromJson(e))
                                .toList();
        
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: list.length,
                                itemBuilder: (context, num) {
                                  return NewsCard(
                                    article: list[num],
                                  );
                                });
                          }
                        } on Exception catch (e) {
                          log(name: "FavoriteTab", "${e.toString()}");
                        }
                      }
                    }
        
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 120.h,
                        ),
                        Lottie.asset(BrandAsset.empty, height: 200.h),
                        Text(BrandTextConstant.noPublishedArticles,style: BrandTextStyle.hintText13,)
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
