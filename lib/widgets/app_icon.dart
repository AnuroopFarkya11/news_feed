import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class InterfaceIcon extends StatelessWidget {
  final IconData icon;
  final Function() onTap;
  const InterfaceIcon({super.key,required this.icon,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h,horizontal: 5.w),
      child: GestureDetector(
        onTap: (){
          onTap();
        },
        child: CircleAvatar(
      
          backgroundColor: Colors.grey.shade200,
          child: Icon(icon,color: Colors.black,),
        ),
      ),
    );
  }
}
