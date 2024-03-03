import 'package:NewsFeed/screens/dashboard/widgets/bottom_bar.dart';
import 'package:NewsFeed/screens/favorite/favorite_tab.dart';
import 'package:NewsFeed/screens/home/ui/home_tab.dart';
import 'package:NewsFeed/screens/profile/profile_tab.dart';
import 'package:NewsFeed/screens/search/search_tab.dart';
import 'package:NewsFeed/widgets/app_icon.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> with TickerProviderStateMixin {


  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }
  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // title: Text(
        //   'Good Evening',
        //   style: TextStyle(
        //       fontWeight: FontWeight.w600,
        //       fontSize: 17.sp,
        //       textBaseline: TextBaseline.alphabetic),
        //
        // ),
        actions: [
          InterfaceIcon(icon: Icons.notification_important, onTap: () {}),
        ],
      ),
      body: TabBarView(
        clipBehavior: Clip.antiAlias,
        dragStartBehavior: DragStartBehavior.down,
        physics: BouncingScrollPhysics(),
        controller: _tabController,
        children:[
          HomeScreenTab(),
          FavoriteTab(),
          SearchTab(),
          ProfileScreen()
        ],
      ),
      bottomNavigationBar: DashBoardBottomBar(tabController: _tabController,),
    );
  }
}
