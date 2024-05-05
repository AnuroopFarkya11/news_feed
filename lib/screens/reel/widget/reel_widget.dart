import 'package:cached_video_player/cached_video_player.dart';
import 'package:com.newsfeed.app/screens/reel/widget/like_animation.dart';
import 'package:com.newsfeed.app/services/firebase_service/firestor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// import 'package:flutter_instagram_clone/data/firebase_service/firestor.dart';
// import 'package:flutter_instagram_clone/util/image_cached.dart';
// import 'package:flutter_instagram_clone/widgets/comment.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReelsItem extends StatefulWidget {
  final snapshot;

  ReelsItem(this.snapshot, {super.key});

  @override
  State<ReelsItem> createState() => _ReelsItemState();
}

class _ReelsItemState extends State<ReelsItem> {
  late CachedVideoPlayerController controller;
  bool play = true;
  bool isAnimating = false;
  String user = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    user = _auth.currentUser!.uid;
    // ignore: deprecated_member_use


    controller = CachedVideoPlayerController.network(widget.snapshot['reelsvideo'])
      ..initialize().then((value) {
        setState(() {
          controller.setLooping(true);
          controller.setVolume(1);
          controller.play();

        });


      });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        GestureDetector(
          onDoubleTap: () {
            // onDoubleTap  Firebase_Firestor().like(
            //       like: widget.snapshot['like'],
            //       type: 'reels',
            //       uid: user,
            //       postId: widget.snapshot['postId']);
            setState(() {
              isAnimating = true;
            });
          },
          onTap: () {
            setState(() {
              play = !play;
            });
            if (play) {
              controller.play();
            } else {
              controller.pause();
            }
          },
          child: Container(
            width: double.infinity,
            height: 812.h, // Adjust height as needed
            child: CachedVideoPlayer(controller),
          ),
        ),
        if (!play)
          Center(
            child: CircleAvatar(
              backgroundColor: Colors.white30,
              radius: 35.r,
              child: Icon(
                Icons.play_arrow,
                size: 35.w,
                color: Colors.white,
              ),
            ),
          ),
        Center(
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 200),
            opacity: isAnimating ? 1 : 0,
            child: LikeAnimation(
              child: Icon(
                Icons.favorite,
                size: 100.w,
                color: Colors.red,
              ),
              isAnimating: isAnimating,
              duration: Duration(milliseconds: 400),
              iconlike: false,
              End: () {
                setState(() {
                  isAnimating = false;
                });
              },
            ),
          ),
        ),
        Positioned(
          top: 430.h,
          right: 15.w,
          child: Column(
            children: [
              LikeAnimation(
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                    size: 24.w,
                  ),
                ),
                isAnimating: false, // Placeholder value
              ),
              SizedBox(height: 3.h),
              Text(
                '0',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 15.h),
              GestureDetector(
                onTap: () {
                  showBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: DraggableScrollableSheet(
                          maxChildSize: 0.6,
                          initialChildSize: 0.6,
                          minChildSize: 0.2,
                          builder: (context, scrollController) {
                            // return Comment('reels', widget.snapshot['postId']);
                            return Container();
                          },
                        ),
                      );
                    },
                  );
                },
                child: Icon(
                  Icons.comment,
                  color: Colors.white,
                  size: 28.w,
                ),
              ),
              SizedBox(height: 3.h),
              Text(
                '0',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 15.h),
              Icon(
                Icons.send,
                color: Colors.white,
                size: 28.w,
              ),
              SizedBox(height: 3.h),
              Text(
                '0',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 40.h,
          left: 10.w,
          right: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipOval(
                    child:
                        SizedBox(height: 35.h, width: 35.w, child: Container()),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    // snapshot['username'],
                    "Usermname",
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Container(
                    alignment: Alignment.center,
                    width: 60.w,
                    height: 25.h,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: Text(
                      'Follow',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Text(
                // snapshot['caption'],
                "Caption",
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
