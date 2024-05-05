import 'dart:io';
import 'package:com.newsfeed.app/constants/brand_asset_constants.dart';
import 'package:com.newsfeed.app/constants/brand_text_constants.dart';
import 'package:com.newsfeed.app/models/article_model.dart';
import 'package:com.newsfeed.app/services/database/sql_base.dart';
import 'package:com.newsfeed.app/widgets/app_dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:com.newsfeed.app/constants/brand_color_constants.dart';
import 'package:com.newsfeed.app/widgets/app_icon.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../../utils/app_theme.dart';

class AddNewsHeader extends StatefulWidget {
  const AddNewsHeader({super.key});

  @override
  State<AddNewsHeader> createState() => _AddNewsHeaderState();
}

class _AddNewsHeaderState extends State<AddNewsHeader> {
  bool isFav = false;

  @override
  void initState() {
    super.initState();
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
      actions: [],
      // toolbarHeight: 50.h,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(BrandAsset.imageURl),
          ),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
            begin: Alignment.topCenter,
            end: Alignment.topCenter,
          )),
          child: InkWell(
            onTap: onAddImageTap,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(
                    child: Column(
                  children: [
                    InterfaceIcon(icon: Icons.add, onTap: onAddImageTap),
                    Text(
                      "Add Cover Image",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                )),
                SizedBox(
                  height: 40,
                ),
                Chip(
                  label: Text("News"),
                  shape: StadiumBorder(side: BorderSide.none),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.h),
                  color: MaterialStateColor.resolveWith(
                      (states) => BrandColors.brandColor),
                ),

                //DateFormat('MMMM d, y h:mm a').format(dateTime)
              ],
            ),
          ),
        ),
      ),
      expandedHeight: 250.h,
    );
  }

  onAddImageTap() {
    AppDialogBox.showCustomDialog(
        context: context,
        title: "Select Image",
        content: Container(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Card(
                  elevation: 0,
                  color: Colors.blue.withOpacity(0.1),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Center(
                      child: Text("Camera"),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 1,
                child: Card(
                  elevation: 0,
                  color: Colors.blue.withOpacity(0.1),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Center(
                      child: Text("Gallery"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
