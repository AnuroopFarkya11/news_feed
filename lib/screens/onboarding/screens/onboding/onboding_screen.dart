import 'dart:ui';

import 'package:cached_video_player/cached_video_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com.newsfeed.app/screens/reel/widget/reel_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rive/rive.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> with SingleTickerProviderStateMixin {
  bool isSignInDialogShown = false;
  late RiveAnimationController _btnAnimationController;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late CachedVideoPlayerController controller;
  bool _isBlack = true; // Flag to toggle between two colors
  Color _currentColor = Colors.black; // Initial color
  late AnimationController _animationController;
  late Animation _colorTween;

  @override
  void initState() {
    super.initState();
    _btnAnimationController = OneShotAnimation("active", autoplay: false);
    controller = CachedVideoPlayerController.asset("assets/onboarding/onboarding.mp4")
      ..initialize().then((value) {

        setState(() {
          controller.setLooping(true);
          controller.setVolume(0);
          controller.play();

        });
      });

    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1999));
    _colorTween = ColorTween(begin: Colors.black, end: Colors.white)
        .animate(_animationController);
    changeColors();
    // _startLoop();
  }
  void _startLoop() {
    // Start a loop to continuously toggle between two colors
    Future.delayed(Duration(seconds: 6), () {
      setState(() {
        _isBlack = !_isBlack; // Toggle between true and false
        _currentColor = _isBlack ? Colors.black : Colors.white;
      });
      _startLoop(); // Restart the loop
    });
  }

  Future changeColors() async {
    while (true) {
      await new Future.delayed(const Duration(seconds: 5), () {
        if (_animationController.status == AnimationStatus.completed) {
          _animationController.reverse();
        } else {
          _animationController.forward();
        }
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        // Positioned(
        //     width: MediaQuery.of(context).size.width * 1.7,
        //     bottom: 200,
        //     left: 100,
        //     child: Image.asset('assets/Backgrounds/Spline.png')),

        Positioned.fill(
            child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        )),


        Container(
          width: double.infinity,
          height: 812.h, // Adjust height as needed
          child: CachedVideoPlayer(controller),
        ),

        // Positioned.fill(
        //     child: BackdropFilter(
        //       filter: ImageFilter.blur(sigmaX: 20, sigmaY: 10),
        //     )),
      // StreamBuilder(stream: _firestore
      //     .collection('reels')
      //     .snapshots(), builder: (context,snapshot) {
      //   return PageView.builder(
      //     itemCount: snapshot.data == null ? 0 : snapshot.data!.docs.length,
      //     scrollDirection: Axis.vertical,
      //     controller: PageController(initialPage: 0, viewportFraction: 1),
      //     itemBuilder:  (context, index) {
      //       if (!snapshot.hasData) {
      //         return CircularProgressIndicator();
      //       }
      //       return ReelsItem(snapshot.data!.docs[index].data());
      //     },
      //   );
      // }),
        Positioned.fill(
            child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: const SizedBox(),
        )),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 240),
          top: isSignInDialogShown ? -50 : 0,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(),
                    SizedBox(
                      width: 260,
                      child: Column(children: [
                        AnimatedBuilder(
                          animation: _colorTween,
                          builder: (BuildContext context, Widget? child) {

                            return Text(
                              "Read \nShare & \nStay Updated",
                              style: TextStyle(
                                  fontSize: 45, fontFamily: "Poppins", height: 1.2,color: _colorTween.value),
                            );
                          },

                        ),

                        SizedBox(
                          height: 16,
                        ),
                        Text(""
                        )
                      ]),
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 24.0),
                      child: Text(
                        "",
                        style: TextStyle(),
                      ),
                    )
                  ]),
            ),
          ),
        )
      ],
    ));
  }
}
