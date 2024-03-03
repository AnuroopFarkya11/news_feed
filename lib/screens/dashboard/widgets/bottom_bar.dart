import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

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
    // TODO: implement initState
    super.initState();
    widget.tabController.addListener(() {
      setState(() {
        selectedIndex = widget.tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withOpacity(.1),
          )
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(

            rippleColor: Colors.grey[300]!,
            hoverColor: Colors.grey[100]!,
            gap: 8,
            activeColor: Colors.white,
            iconSize: 24,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: Duration(milliseconds: 100),
            tabBackgroundColor: Colors.blue,
            color: Colors.black,
            haptic: true,
            curve: Curves.easeIn,

            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.favorite,
                text: 'Likes',
              ),
              GButton(
                icon: Icons.search,
                text: 'Search',
              ),
              GButton(
                icon: Icons.person,
                text: 'Profile',
              ),
            ],
            selectedIndex:selectedIndex,
            onTabChange: (index) {
              print("index $index");
              widget.tabController.index = index;
            },
          ),
        ),
      ),
    );
  }
}
