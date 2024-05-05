import 'package:com.newsfeed.app/constants/brand_color_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class BrandTextStyle {
  /// title
  static TextStyle? title = TextStyle(
    color: BrandColors.black,
    fontWeight: FontWeight.w600,
    fontSize: 20.sp,
    textBaseline: TextBaseline.alphabetic,
  );

  static TextStyle? body15 = TextStyle(
      color: Colors.blue,
      fontWeight: FontWeight.w500,
      fontSize: 15.sp,
      textBaseline: TextBaseline.alphabetic,
      overflow: TextOverflow.ellipsis);

  /// the below style will be used for text below animation
  static TextStyle? hintText13 =
      TextStyle(color: Colors.black45, fontSize: 13.sp);
}
