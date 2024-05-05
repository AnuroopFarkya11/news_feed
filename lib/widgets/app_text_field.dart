import 'package:com.newsfeed.app/constants/brand_color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppTextField extends StatefulWidget {

  final String labelText;
  final TextEditingController controller;
  final int? maxLines;
  final bool? obscureText;
  final String? svgPath;
  final String? hintText;

  const AppTextField(this.controller,this.labelText,{super.key,this.maxLines,this.obscureText,this.svgPath,this.hintText});

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      maxLines: widget.maxLines ?? 1,
      obscureText: widget.obscureText??false,

      decoration: InputDecoration(

        labelStyle: TextStyle(fontSize: 16.sp),
        labelText: widget.labelText,
        floatingLabelStyle: TextStyle(color: BrandColors.brandColor,fontSize: 18.sp),
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(20.0),
        ),
        filled: true,
        fillColor: Colors.blueAccent.shade200.withOpacity(0.1),
        prefixIconConstraints: BoxConstraints.tight(Size.square(35.sp)),
        prefixIcon: widget.svgPath!=null?Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9),
          child: SvgPicture.asset("assets/interface/${widget.svgPath}",color: Colors.blueAccent.withOpacity(0.9),height: 5.sp,),
        ):null
      ),
    );;
  }
}
