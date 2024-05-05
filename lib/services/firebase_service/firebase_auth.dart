import 'dart:io';

import 'package:com.newsfeed.app/services/firebase_service/firestor.dart';
import 'package:com.newsfeed.app/services/firebase_service/storage.dart';
import 'package:com.newsfeed.app/utils/app_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';



class Authentication {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> Login({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
    } on FirebaseException catch (e) {
      String message = AppUtils.handleFirebaseException(e);

      throw Exception(message);
    }
  }

  Future<void> Signup({
    required String email,
    required String password,
    required String passwordConfirme,
    required String username,
    required String bio,
    required File profile,
  }) async {
    String URL;
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          username.isNotEmpty) {
        if (password == passwordConfirme) {
          // create user with email and password
          await _auth.createUserWithEmailAndPassword(
            email: email.trim(),
            password: password.trim(),
          );
          // upload profile image on storage

          if (profile != File('')) {
            URL =
                await StorageMethod().uploadImageToStorage('Profile', profile);
          } else {
            URL = '';
          }

          // get information with firestor

          await Firebase_Firestor().CreateUser(
            email: email,
            username: username,
            bio: "",
            profile: URL == ''
                ? 'https://firebasestorage.googleapis.com/v0/b/instagram-8a227.appspot.com/o/person.png?alt=media&token=c6fcbe9d-f502-4aa1-8b4b-ec37339e78ab'
                : URL,
          );
        } else {
          throw Exception('password and confirm password should be same');
        }
      } else {
        throw Exception('enter all the fields');
      }
    } on FirebaseException catch (e) {
      throw Exception(e.message.toString());
    }
  }


  Future<void> logout()
 async {
    try {
      await _auth.signOut();
    } on FirebaseException catch (e) {
      throw Exception(e.message.toString());
    }
  }

}
