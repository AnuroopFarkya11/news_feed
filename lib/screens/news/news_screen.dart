import 'package:com.newsfeed.app/constants/brand_style_constants.dart';
import 'package:com.newsfeed.app/constants/brand_text_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:com.newsfeed.app/screens/news/widget/news_header.dart';
import 'package:screenshot/screenshot.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/article_model.dart';

class NewsPage extends StatefulWidget {
  NewsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  Article? article;
  late String newsDetails =
      article?.description ?? BrandTextConstant.description;
  bool click = false;
  ScreenshotController _screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
  }
  DateTime dateTime =DateTime.now();

  @override
  Widget build(BuildContext context) {
    _initArticle();

    if(article?.publishedAt!=null && article?.publishedAt!="")
      {
        dateTime =
        DateTime.parse(article?.publishedAt ?? DateTime.now().toString());
      }


    return Scaffold(
        backgroundColor: Colors.black,
        body: Screenshot(
          controller: _screenshotController,
          child: CustomScrollView(
              physics: NeverScrollableScrollPhysics(),
              slivers: [
                NewsHeader(
                  screenshotController: _screenshotController,
                  imageUrl: article?.urlToImage,
                  title: article?.title,
                  dateTime: dateTime,
                  article: article,
                ),
                SliverFillRemaining(
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 20.h, horizontal: 15.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.r),
                              topRight: Radius.circular(20.r)),
                          color: Colors.white,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  article?.author ?? BrandTextConstant.author,
                                  style: BrandTextStyle.body15,
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        click
                                            ? newsDetails
                                            : newsDetails += '\n';
                                        click
                                            ? newsDetails
                                            : newsDetails +=
                                                article?.content ?? "";
                                        click = true;
                                      });
                                    },
                                    child: Text(
                                      newsDetails +
                                          "${click ? "" : BrandTextConstant.clickDescription}",
                                      style: TextStyle(
                                          fontSize: 13.sp,
                                          color: click
                                              ? Colors.black
                                              : Colors.blue.shade900),
                                    )),
                                SizedBox(
                                  height: 10.h,
                                ),
                                InkWell(
                                  onTap: () async {
                                    Uri uri = Uri.parse(article?.url ??
                                        BrandTextConstant.googleUrl);

                                    if (await launchUrl(uri)) {
                                      SnackBar snackBar = SnackBar(
                                          content: Text(
                                              "${BrandTextConstant.opening} ${article?.url ?? BrandTextConstant.googleUrl}"));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    } else {
                                      SnackBar snackBar = SnackBar(
                                          content: Text(
                                              BrandTextConstant.failedToOpen));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    }
                                  },
                                  child: Text(
                                    // "",
                                    '${BrandTextConstant.visit}:${article?.src ?? BrandTextConstant.googleDomain}',
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                )
                              ]),
                        )))
              ]),
        ));
  }

  void _initArticle() {
    article = ModalRoute.of(context)?.settings.arguments as Article;
    print("_initArticle : ${article?.src}");
  }
}

/*
*
* NewsPageHeader(
                  title: article.title ?? 'Breaking News',
                  imageAssetPath: article.urlToImage ??
                      "https://t3.ftcdn.net/jpg/03/27/55/60/360_F_327556002_99c7QmZmwocLwF7ywQ68ChZaBry1DbtD.jpg",
                  category: "News",
                  date: dateTime,
                  minExtent: topPadding + 56,
                  maxExtent: maxScreenSize / 2)
*
* */
