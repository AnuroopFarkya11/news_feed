import 'package:com.newsfeed.app/constants/brand_color_constants.dart';
import 'package:com.newsfeed.app/widgets/bottom_bar/google_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashBoardBottomBar extends StatefulWidget {
  final TabController tabController;

  const DashBoardBottomBar({super.key, required this.tabController});

  @override
  State<DashBoardBottomBar> createState() => _DashBoardBottomBarState();
}

class _DashBoardBottomBarState extends State<DashBoardBottomBar> {

  int selectedIndex=0;
  @override
  void initState() {
    super.initState();
    // widget.tabController.addListener(() {
    //   setState(() {
    //     selectedIndex = widget.tabController.index;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 2),
        child: GNav(
          rippleColor: Colors.grey[300]!,
          hoverColor: Colors.grey[100]!,
          gap: 2,
          activeColor: Colors.white,
          iconSize: 24,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          duration: Duration(milliseconds: 100),
          tabBackgroundColor: BrandColors.brandColor,
          color: Colors.black,
          haptic: true,
          curve: Curves.easeIn,
      
          tabs: [
            GButton(
              svgPath: "assets/interface/home.svg",
              iconColor: Colors.grey,
            ),

            GButton(
              svgPath: "assets/interface/heart.svg",
              iconColor: Colors.grey,

            ),

            GButton(
              svgPath: "assets/interface/camera-movie.svg",
              iconColor: Colors.grey,

            ),
            GButton(
              svgPath: "assets/interface/search.svg",
              iconColor: Colors.grey,

            ),
            GButton(
              svgPath: "assets/interface/user.svg",
              iconColor: Colors.grey,

            ),

          ],
          selectedIndex:selectedIndex,
          onTabChange: (index) {
            print("index $index");
            widget.tabController.index = index;
          },
        ),
      ),
    );
  }
}
