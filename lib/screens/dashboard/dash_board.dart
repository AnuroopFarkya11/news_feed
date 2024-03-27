import 'package:NewsFeed/constants/brand_text_constants.dart';
import 'package:NewsFeed/screens/dashboard/widgets/bottom_bar.dart';
import 'package:NewsFeed/screens/favorite/favorite_tab.dart';
import 'package:NewsFeed/screens/home/ui/home_tab.dart';
import 'package:NewsFeed/screens/profile/profile_tab.dart';
import 'package:NewsFeed/screens/search/search_tab.dart';
import 'package:NewsFeed/constants/brand_style_constants.dart';
import 'package:NewsFeed/constants/brand_color_constants.dart';
import 'package:NewsFeed/widgets/app_icon.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

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
    return Container(
      color: BrandColors.white,
      child: Scaffold(
        endDrawer: Drawer(
          child: SafeArea(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    BrandTextConstant.notification,
                    style: BrandTextStyle.title,),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Lottie.asset('assets/animation/notification.json',
                            height: 100.h),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          BrandTextConstant.noNotification,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black45),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            Builder(
              builder: (context) => InterfaceIcon(
                  icon: Icons.notification_important,
                  onTap: () {
                    Scaffold.of(context).openEndDrawer();
                  }),
            ),
          ],
        ),
        body: TabBarView(
          clipBehavior: Clip.antiAlias,
          dragStartBehavior: DragStartBehavior.down,
          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: [
            HomeScreenTab(),
            FavoriteTab(),
            SearchTab(),
            ProfileScreen()
          ],
        ),
        bottomNavigationBar: DashBoardBottomBar(
          tabController: _tabController,
        ),
      ),
    );
  }
}
