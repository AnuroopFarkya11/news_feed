import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:intl/intl.dart';

import '../models/article_model.dart';

class NewsCard extends StatelessWidget {
  final Article? article;

  const NewsCard({super.key, this.article});

  @override
  Widget build(BuildContext context) {
    String? utcTimeString = article?.publishedAt;
    DateTime utcTime = DateTime.parse(utcTimeString!);
    String formattedTime =
        DateFormat.yMMMMd().add_jms().format(utcTime.toLocal());
    return Container(
      height: 120.h,
      margin: EdgeInsets.symmetric(vertical: 7.h, horizontal: 10.w),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.network(
              article?.urlToImage ??
                  "https://t3.ftcdn.net/jpg/03/27/55/60/360_F_327556002_99c7QmZmwocLwF7ywQ68ChZaBry1DbtD.jpg",
              fit: BoxFit.cover,
              height: 110.h,
              width: 120.w,
            ),
          ),
          SizedBox(
            width: 15.w,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "News",
                  style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                ),
                SizedBox(
                  height: 6.h,
                ),
                Text(
                  article?.title ?? "You must know why this is a breaking news",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style:
                      TextStyle(fontWeight: FontWeight.w700, fontSize: 15.sp),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: Image.network(
                              "https://t4.ftcdn.net/jpg/03/83/25/83/360_F_383258331_D8imaEMl8Q3lf7EKU2Pi78Cn0R7KkW9o.jpg")
                          .image,
                      radius: 15.r,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    SizedBox(
                        width: 90.w,
                        child: Text(
                          article?.author ?? "Author",
                          style: TextStyle(color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                        )),
                    SizedBox(
                      width: 10.w,
                    ),
                    SizedBox(
                        width: 50.w,
                        child: Text(
                          formattedTime ?? "",
                          style: TextStyle(color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                        )),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
