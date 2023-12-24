import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:siyatech/utils/app_constants.dart';
import 'package:siyatech/utils/brand_colors.dart';
import 'package:siyatech/widgets/app_icon.dart';

import '../../../utils/app_theme.dart';

class NewsHeader extends StatelessWidget {
  final String? imageUrl;
  final String? title;
  final DateTime? dateTime;

  const NewsHeader({super.key, this.imageUrl, this.title, this.dateTime});

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
      actions: [InterfaceIcon(icon: Icons.save_alt, onTap: () {}),
      InterfaceIcon(icon: Icons.more_horiz_outlined, onTap: (){})
      ],
      // toolbarHeight: 50.h,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(imageUrl??AppConstants.imageURl),
          ),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 20.h),
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
                "${title ?? AppConstants.title}",
                maxLines: 3,
                style: TextStyle(
                    color: BrandColors.white,
                    overflow: TextOverflow.ellipsis,
                    fontSize: title!.length>20?16.sp:20.sp,
                    // wordSpacing: 3.w,
                    letterSpacing: 1.w,
                    fontWeight: FontWeight.w600,
                ),
              ),
              
              SizedBox(height: 10.h,),
              Text(DateFormat('MMMM d, y h:mm a').format(dateTime!),style: TextStyle(color: Colors.white,fontWeight: FontWeight.w300,fontSize: 10.sp),)
            //DateFormat('MMMM d, y h:mm a').format(dateTime)
            ],
          ),
        ),
      ),
      expandedHeight: 250.h,
    );
  }
}
