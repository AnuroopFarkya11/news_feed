import 'dart:io';
import 'package:com.newsfeed.app/constants/brand_asset_constants.dart';
import 'package:com.newsfeed.app/constants/brand_text_constants.dart';
import 'package:com.newsfeed.app/models/article_model.dart';
import 'package:com.newsfeed.app/services/database/sql_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:com.newsfeed.app/constants/brand_color_constants.dart';
import 'package:com.newsfeed.app/widgets/app_icon.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../../utils/app_theme.dart';

class NewsHeader extends StatefulWidget {
  final String? imageUrl;
  final String? title;
  final DateTime? dateTime;
  final Article? article;
  final ScreenshotController screenshotController;

  const NewsHeader(
      {super.key,required this.screenshotController, this.imageUrl, this.title, this.dateTime, this.article});

  @override
  State<NewsHeader> createState() => _NewsHeaderState();
}

class _NewsHeaderState extends State<NewsHeader> {
  bool isFav = false;

  @override
  void initState() {
    super.initState();
    checkIsFav();
  }

  checkIsFav() async {
    await DBBase.checkIsLiked(widget.article!.title??'').then((bool res) {
      setState(() {
        isFav = res;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: InterfaceIcon(
        icon: Icons.arrow_back_ios_new_rounded,
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
      actions: [
        InterfaceIcon(
            icon: isFav ? Icons.favorite : Icons.favorite_border,
            onTap: () async {
              if (widget.article != null && isFav == false) {
                await DBBase.insertArticle(widget.article!.toJson()).then((int res) {
                  setState(() {
                    isFav = true;
                  });
                });
              } else {
                if (isFav == true) {
                  await DBBase.deleteArticle(title: widget.article!.title)
                      .then((int value) {
                    if (value > 0) {
                      setState(() {
                        isFav = false;
                      });
                    }
                  });
                }
              }
            }),
        InterfaceIcon(icon: Icons.share, onTap: () async{
          // Directory directory = await getApplicationDocumentsDirectory();
          // widget.screenshotController.captureAndSave("$directory",fileName: "ss",pixelRatio: 100);



          await widget.screenshotController.capture(delay: const Duration(milliseconds: 10)).then((var image) async {
            if (image != null) {
              print("image captured");
              final directory = await getApplicationDocumentsDirectory();
              final imagePath = await File('${directory.path}/image.png').create();
              await imagePath.writeAsBytes(image);

              /// Share Plugin
              await Share.shareFiles([imagePath.path]);
            }
          });

        })
      ],
      // toolbarHeight: 50.h,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(widget.imageUrl ?? BrandAsset.imageURl),
          ),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [Colors.transparent, Colors.black.withOpacity(0.9)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Chip(
                label: Text("News"),
                shape: StadiumBorder(side: BorderSide.none),
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.h),
                color: MaterialStateColor.resolveWith((states) => Colors.blue),
              ),

              SizedBox(
                height: 10.h,
              ),
              //title??
              Text(
                widget.title ?? BrandTextConstant.homeTitle,
                maxLines: 3,
                style: TextStyle(
                  color: BrandColors.white,
                  overflow: TextOverflow.ellipsis,
                  fontSize: widget.title!.length > 20 ? 16.sp : 20.sp,
                  // wordSpacing: 3.w,
                  letterSpacing: 1.w,
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(
                height: 10.h,
              ),
              Text(
                DateFormat('MMMM d, y h:mm a').format(widget.dateTime!),
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 10.sp),
              )
              //DateFormat('MMMM d, y h:mm a').format(dateTime)
            ],
          ),
        ),
      ),
      expandedHeight: 250.h,
    );
  }
}
