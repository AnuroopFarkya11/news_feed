import 'package:NewsFeed/routes/route_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../models/article_model.dart';

class BreakingNewsCard extends StatelessWidget {
  final Article? article;
  bool isShimmer = false;

  BreakingNewsCard({Key? key, required this.article}) : super(key: key);

  BreakingNewsCard.shimmerCard({this.article}) {
    this.isShimmer = true;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isShimmer) {
          Navigator.of(context)
              .pushNamed(RoutePath.newsScreen, arguments: article);
        }
      },
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: isShimmer? Shimmer.fromColors(baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,child: Container(color: Colors.black,),):Stack(children: [
            Image.network(
              article?.urlToImage ??
                  "https://t3.ftcdn.net/jpg/03/27/55/60/360_F_327556002_99c7QmZmwocLwF7ywQ68ChZaBry1DbtD.jpg",
              fit: BoxFit.cover,
              width: double.maxFinite,
              height: double.maxFinite,
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      article?.author ?? " ",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(article?.title ?? '',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
