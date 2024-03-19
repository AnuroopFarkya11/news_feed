import 'dart:developer';
import 'package:NewsFeed/constants/brand_asset_constants.dart';
import 'package:NewsFeed/constants/brand_style_constants.dart';
import 'package:NewsFeed/constants/brand_text_constants.dart';
import 'package:NewsFeed/models/article_model.dart';
import 'package:NewsFeed/services/database/sql_base.dart';
import 'package:NewsFeed/widgets/news_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class FavoriteTab extends StatefulWidget {
  const FavoriteTab({super.key});

  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 13,),

        Container(
          margin: EdgeInsets.symmetric(horizontal: 10.w),
          child: Text(
            BrandTextConstant.favoriteTitle,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20.sp,
                textBaseline: TextBaseline.alphabetic),
          ),
        ),
        Center(
          child: FutureBuilder(
              future: DBBase.queryAllLikedNews(),
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
                    Text(BrandTextConstant.noLikedArticles,style: BrandTextStyle.hintText13,)
                  ],
                );
              }),
        ),
      ],
    );
  }
}
