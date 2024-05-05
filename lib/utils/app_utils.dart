import 'package:com.newsfeed.app/constants/brand_color_constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppUtils {
  static showAppSnackBar({required BuildContext context, String? content}) {
    SnackBar snackBar = SnackBar(
      content: Text(
        '${content ?? 'Something went wrong.'}',
        style: TextStyle(fontWeight: FontWeight.w500, color: BrandColors.white),
      ),
      backgroundColor: BrandColors.brandColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static String handleFirebaseException(FirebaseException e) {
    print("handleFirebaseException: ${e.code}");
    switch (e.code) {
      case 'invalid-email':
        return 'The email address is malformed.';
      case 'user-disabled':
        return 'The user corresponding to the given email has been disabled.';
      case 'user-not-found':
        return 'There is no user corresponding to the given email.';
      case 'wrong-password':
        return 'The password is invalid for the given email.';
      case 'email-already-in-use':
        return 'The email address is already in use by another account.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled.';
      case 'weak-password':
        return 'The password is not strong enough.';
      case 'network-request-failed':
        return 'A network error occurred. Please check your internet connection.';
      default:
        return 'An unknown error occurred. Please try again later.';
    }
  }

}
