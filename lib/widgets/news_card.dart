
import 'package:com.newsfeed.app/constants/brand_asset_constants.dart';
import 'package:com.newsfeed.app/constants/brand_text_constants.dart';
import 'package:com.newsfeed.app/routes/route_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:intl/intl.dart';

import '../models/article_model.dart';

class NewsCard extends StatefulWidget {
  final Article? article;

  const NewsCard({super.key, this.article});

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  @override
  Widget build(BuildContext context) {
    String? utcTimeString = widget.article?.publishedAt;
    String formattedTime='-';
    if(utcTimeString!=null&&utcTimeString!="")
      {
        DateTime? utcTime = DateTime.parse(utcTimeString);
        String formattedTime =
        DateFormat.yMMMMd().add_jms().format(utcTime.toLocal());
      }

    return GestureDetector(
      onTap: (){

        // Navigator.pushNamed(context,RoutePath.newsScreen,arguments: );
        Navigator.pushNamed(context, RoutePath.newsScreen,arguments: widget.article).then((value){

          setState(() {

          });
        });
      },
      child: Container(
        height: 120.h,
        margin: EdgeInsets.symmetric(vertical: 7.h, horizontal: 10.w),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.network(
                widget.article?.urlToImage ??
                    BrandAsset.imageURl,
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
                    height: 5.h,
                  ),
                  Text(
                    "News",
                    style: TextStyle(color: Colors.grey, fontSize: 10.sp),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Text(
                    widget.article?.title ?? "You must know why this is a breaking news",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 12.sp),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: Image.network(
                                BrandAsset.userImage)
                            .image,
                        radius: 10.r,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      SizedBox(
                          width: 90.w,
                          child: Text(
                            widget.article?.author ?? "Author",
                            style: TextStyle(color: Colors.grey,fontSize: 10.sp),
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
      ),
    );
  }
}
