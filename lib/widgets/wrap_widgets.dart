import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectableContainer extends StatefulWidget {
  final int index;
  final bool isSelected;
  final String customName;
  final VoidCallback onTap;

  const SelectableContainer({super.key,
    required this.index,
    required this.isSelected,
    required this.customName,
    required this.onTap,
  });

  @override
  State<SelectableContainer> createState() => _SelectableContainerState();
}

class _SelectableContainerState extends State<SelectableContainer> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        width: 80.h,
        height: 35.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          color:Colors.blue ,
        ),

        child: Center(
          child: Text(
            widget.customName,
            style: TextStyle(
              fontSize: 10.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}