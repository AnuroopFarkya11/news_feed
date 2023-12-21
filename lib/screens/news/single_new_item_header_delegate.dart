import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

import '../../utils/app_theme.dart';


class SingleNewsItemHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String title;
  final String category;
  final String imageAssetPath;
  final DateTime date;
  @override
  final double maxExtent;

  @override
  final double minExtent;

  const SingleNewsItemHeaderDelegate(
      {required this.title,
      required this.category,
      required this.imageAssetPath,
      required this.date,
      required this.maxExtent,
      required this.minExtent});



  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {


    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          imageAssetPath,
          fit: BoxFit.cover,
        ),
        Positioned(
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  AppColors.black08,
                  AppColors.black06,
                  AppColors.black00
                ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter
                )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Chip(
                    label: Text(
                      category,
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.orange,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width -40,
                    child: Text(
                      title,
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("22 December" , style: TextStyle(color: Colors.white),)
                ],
              ),
            ))
      ],
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;

  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration =>
      OverScrollHeaderStretchConfiguration();
}
