import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com.newsfeed.app/blocs/hmmBloc.dart';
import 'package:com.newsfeed.app/constants/brand_text_constants.dart';
import 'package:com.newsfeed.app/routes/route_path.dart';
import 'package:com.newsfeed.app/screens/dashboard/widgets/bottom_bar.dart';
import 'package:com.newsfeed.app/screens/favorite/favorite_tab.dart';
import 'package:com.newsfeed.app/screens/home/ui/home_tab.dart';
import 'package:com.newsfeed.app/screens/profile/profile_tab.dart';
import 'package:com.newsfeed.app/screens/reel/reel_tab.dart';
import 'package:com.newsfeed.app/screens/search/search_tab.dart';
import 'package:com.newsfeed.app/constants/brand_style_constants.dart';
import 'package:com.newsfeed.app/constants/brand_color_constants.dart';
import 'package:com.newsfeed.app/widgets/app_icon.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> with TickerProviderStateMixin {
  late TabController _tabController;
  late FirebaseFirestore _fireStore;
  // late ReelBloc _reelBloc;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _fireStore = FirebaseFirestore.instance;
    // _reelBloc = ReelBloc(const AsyncSnapshot.nothing());
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

      appBar:AppBar(
        // backgroundColor: Colors.transparent,
        elevation: 0,

        actions: [


          InterfaceIcon(icon: Icons.add, onTap: (){
            Navigator.pushNamed(context, RoutePath.addNewsPage);
          }),

          Builder(
            builder: (context) => InterfaceIcon(
                icon: Icons.notification_important,
                onTap: () {
                  Scaffold.of(context).openEndDrawer();
                }),
          ),
        ],
      ),
      body: StreamBuilder(
        stream:_fireStore
            .collection('reels')
            .snapshots(),
        builder: (context,snapshot) {
          // _reelBloc.updateSnapshot(snapshot);

          context.read<ReelBloc>().updateSnapshot(snapshot);

          return TabBarView(
            clipBehavior: Clip.antiAlias,
            dragStartBehavior: DragStartBehavior.down,
            physics: NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: [
              HomeScreenTab(),
              FavoriteTab(),
              ReelTab(),
              SearchTab(),
              ProfileScreen()
            ],
          );
        }
      ),


      bottomNavigationBar: DashBoardBottomBar(
        tabController: _tabController,
      ),
      // floatingActionButton:  DashBoardBottomBar(
      //   tabController: _tabController,
      // ),
      //
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }
}
