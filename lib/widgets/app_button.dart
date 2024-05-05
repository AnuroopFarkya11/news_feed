import 'package:com.newsfeed.app/constants/brand_color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatefulWidget {
  final String? buttonTxt;
  final Function()? onTap;
  final Function()? isLoading;

  const AppButton({super.key, this.buttonTxt, this.onTap, this.isLoading});

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool isLoadingBool = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.isLoading != null) {
          Future.delayed(const Duration(milliseconds: 200), () {
            isLoadingBool = true;
          });
          widget.isLoading!();
        }
        if (widget.onTap != null) {
          widget.onTap!();
        }

        isLoadingBool = false;

        if (widget.isLoading != null) {

          widget.isLoading!();
        }
      },
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 44.h,
        decoration: BoxDecoration(
          color: BrandColors.brandColor,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Text(
          isLoadingBool ? "Please wait..." : widget.buttonTxt ?? "Continue",
          style: TextStyle(
            fontSize: 17.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
