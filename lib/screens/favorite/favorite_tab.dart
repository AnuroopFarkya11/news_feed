import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class FavoriteTab extends StatelessWidget {
  const FavoriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [

        SizedBox(height: 120.h,),
        Lottie.asset('assets/animation/empty.json',height: 200.h),

        Text("Oops! There is no liked articles.")
      ],
    );
  }
}
