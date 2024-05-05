import 'dart:io';

import 'package:com.newsfeed.app/constants/brand_color_constants.dart';
import 'package:com.newsfeed.app/services/database/sql_base.dart';
import 'package:com.newsfeed.app/services/firebase_service/firebase_auth.dart';
import 'package:com.newsfeed.app/utils/dialog.dart';
import 'package:com.newsfeed.app/utils/imagepicker.dart';
import 'package:com.newsfeed.app/widgets/app_text_field.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class SignupScreen extends StatefulWidget {
  final VoidCallback show;

  SignupScreen(this.show, {super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final email = TextEditingController();
  FocusNode email_F = FocusNode();
  final password = TextEditingController();
  FocusNode password_F = FocusNode();
  final passwordConfirm = TextEditingController();
  FocusNode passwordConfirme_F = FocusNode();
  final username = TextEditingController();
  FocusNode username_F = FocusNode();
  final bio = TextEditingController();
  FocusNode bio_F = FocusNode();
  File? _imageFile;

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    password.dispose();
    passwordConfirm.dispose();
    username.dispose();
    bio.dispose();
  }



  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(width: 96.w, height: 40.h),
              Text(
                "Sign Up",
                style: TextStyle(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Please enter your details.",
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey
                ),
              ),
              SizedBox(height: 10.h),
              
              Center(
                child: Column(
                  
                  children: [
                    GestureDetector(
                        onTap: () async {
                          File _imagefilee =
                          await ImagePickerr().uploadImage('gallery');
                          setState(() {
                            _imageFile = _imagefilee;
                          });
                        },
                        child: _imageFile == null
                            ? Lottie.asset(
                            "assets/profilelottie.json",
                            repeat: true,
                            height: 200.h,
                
                        )
                            : CircleAvatar(
                          radius: 85.r,
                          backgroundImage: Image.file(
                            _imageFile!,
                            fit: BoxFit.cover,
                          ).image,
                          backgroundColor: Colors.grey.shade200,
                        )),
                
                    _imageFile == null ?Text(
                      "Add your picture",
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey
                      ),
                    ):Container()
                  ],
                ),
              ),

              SizedBox(height: 20.h),
              // Textfild(email, email_F, 'Email', Icons.email),
              AppTextField(email, "Email",svgPath: "envelope.svg",),

              SizedBox(height: 15.h),
              // Textfild(username, username_F, 'username', Icons.person),
              AppTextField(username, "Username",svgPath: "user.svg",),
              SizedBox(height: 15.h),
              AppTextField(password, "Password",svgPath: "lock _password.svg",obscureText: true,),
              SizedBox(height: 15.h),
              AppTextField(passwordConfirm, "Confirm Password",svgPath: "lock.svg",obscureText: true,),
              SizedBox(height: 25.h),
              Signup(),
              SizedBox(height: 15.h),
              Have()
            ],
          ),
        ),
      ),
    );
  }

  Widget Have() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Don you have account?  ",
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey,
            ),
          ),
          GestureDetector(
            onTap: widget.show,
            child: Text(
              "Login ",
              style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget Signup() {
    return InkWell(
      onTap: () async {
        try {
          await Authentication().Signup(
            email: email.text,
            password: password.text,
            passwordConfirme: passwordConfirm.text,
            username: username.text,
            bio: bio.text,
            profile: _imageFile ?? File(''),
          );

          await DBBase.insertUser({
            "userId" : email.text,
            "name":username.text,
            "email":email.text,
            "password":password.text,
            "profile":"",
            "country":"in"
          });
        } on Exception catch (e) {
          dialogBuilder(context, e.toString());
        }
      },
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 44.h,
        decoration: BoxDecoration(
          color: BrandColors.brandColor,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Text(
          'Sign up',
          style: TextStyle(
            fontSize: 17.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Padding Textfild(TextEditingController controll, FocusNode focusNode,
      String typename, IconData icon) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Container(
        height: 44.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: TextField(
          style: TextStyle(fontSize: 18.sp, color: Colors.black),
          controller: controll,
          focusNode: focusNode,
          decoration: InputDecoration(
            hintText: typename,
            prefixIcon: Icon(
              icon,
              color: focusNode.hasFocus ? Colors.black : Colors.grey[600],
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
              borderSide: BorderSide(
                width: 2.w,
                color: Colors.grey,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
              borderSide: BorderSide(
                width: 2.w,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
