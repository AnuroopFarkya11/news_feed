import 'package:com.newsfeed.app/screens/auth/auth_screen.dart';
import 'package:com.newsfeed.app/screens/dashboard/dash_board.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


/*
* Landing page:
* This Page is responsible auth state.
*
*
*
* */
class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:_getBody(),
    );
  }

  Widget _getBody() {
    return  StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const DashBoard();
        } else {
          return const AuthScreen();
        }
      },
    );
  }
}
