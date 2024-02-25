import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:NewsFeed/screens/news/widget/news_header.dart';
import 'package:NewsFeed/widgets/single_header_delegate.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/article_model.dart';

class NewsPage extends StatefulWidget {
  final Article? article;

  NewsPage({Key? key, this.article}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late String newsDetails = widget.article?.description ?? "Description";
  bool click = false;

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(
        widget.article?.publishedAt ?? DateTime.now().toString());
    final topPadding = ScreenUtil().statusBarHeight;
    final maxScreenSize = ScreenUtil().screenHeight;
    return Scaffold(
        backgroundColor: Colors.black,
        body:
            CustomScrollView(physics: NeverScrollableScrollPhysics(), slivers: [
          NewsHeader(
            imageUrl: widget.article?.urlToImage,
            title: widget.article?.title,
            dateTime: dateTime,
          ),
          SliverFillRemaining(
              child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
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
                            widget.article?.author ?? "Author",
                            style: TextStyle(
                                fontSize: 15.sp,
                                overflow: TextOverflow.ellipsis),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          InkWell(
                              onTap: () {
                                setState(() {
                                  click ? newsDetails : newsDetails += '\n';
                                  click
                                      ? newsDetails
                                      : newsDetails +=
                                          widget.article?.content ?? "";
                                  click = true;
                                });
                              },
                              child: Text(
                                newsDetails +
                                    "${click ? "" : "\n(click here for description)"}",
                                style: TextStyle(
                                    fontSize: 13.sp,
                                    color: click ? Colors.black : Colors.blue.shade900),
                              )),

                          SizedBox(height: 10.h,),
                          InkWell(
                            onTap: ()async{
                              Uri uri = Uri.parse(widget.article?.url??"www.google.com");

                              if(await launchUrl(uri)){
                                SnackBar snackBar = SnackBar(content: Text("Opening ${widget.article?.url??"www.google.com"}"));
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              }
                              else{
                                SnackBar snackBar = SnackBar(content: Text("Failed to open url"));
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              }


                            },
                            child: Text(
                              'Visit:${widget.article?.source['name']??"Google.com"}',
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          )

                        ]),
                  )))
        ]));
  }
}

/*
*
* NewsPageHeader(
                  title: article?.title ?? 'Breaking News',
                  imageAssetPath: article?.urlToImage ??
                      "https://t3.ftcdn.net/jpg/03/27/55/60/360_F_327556002_99c7QmZmwocLwF7ywQ68ChZaBry1DbtD.jpg",
                  category: "News",
                  date: dateTime,
                  minExtent: topPadding + 56,
                  maxExtent: maxScreenSize / 2)
*
* */
