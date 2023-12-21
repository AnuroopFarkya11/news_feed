import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:siyatech/widgets/single_header_delegate.dart';


import '../../models/article_model.dart';

class SingleNewsItemPage extends StatelessWidget {
  final Article? article;
  SingleNewsItemPage({Key? key,this.article})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? utcTimeString = article?.publishedAt ;
    DateTime utcTime = DateTime.parse(utcTimeString!);
    String formattedTime = DateFormat.yMMMMd().add_jms().format(utcTime.toLocal());
    DateTime dateTime = DateTime.parse(article!.publishedAt);
    final topPadding = MediaQuery
        .of(context)
        .padding
        .top;
    final maxScreenSize = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
        backgroundColor: Colors.black,
        body: CustomScrollView(slivers: [
          SliverPersistentHeader(delegate: SingleNewsItemHeaderDelegate(
              title:article?.title??'Breaking News' ,
              imageAssetPath: article?.urlToImage??"https://t3.ftcdn.net/jpg/03/27/55/60/360_F_327556002_99c7QmZmwocLwF7ywQ68ChZaBry1DbtD.jpg",
              category: "News",
              date: dateTime,// todo
              minExtent: topPadding + 56,
              maxExtent: maxScreenSize / 2)),
          SliverFillRemaining(
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20.h,horizontal: 10.w),
                  decoration:
                  BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r),topRight: Radius.circular(20.r)),
                    color: Colors.white,),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(article?.author??"Author"),
                        SizedBox(
                          height: 30,
                        ),
                        Text(article?.description??"Description")
                      ])))
        ]));
  }
}
