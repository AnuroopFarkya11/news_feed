import 'dart:ui';

import 'package:com.newsfeed.app/screens/auth/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import 'signUp/sign_up_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool a = true;

  void go() {
    setState(() {
      a = !a;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _getBody(),
    );
  }

  Widget _getBody() {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height, 
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Lottie.asset("assets/animation/gradient.json",height: 250.h,fit: BoxFit.fill),
            ),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: const SizedBox(),
              ),
            ),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: a ? LoginScreen(go) : SignupScreen(go),
            ),
          ],
        ),
      ),
    );

  }
}
