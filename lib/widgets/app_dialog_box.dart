import 'package:NewsFeed/constants/brand_color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDialogBox {
  static _getDialogButton(
      {required String content, required Function() onTap}) {
    return CupertinoButton(
        onPressed: onTap,
        child: Text(
          content,
          style: TextStyle(color: BrandColors.black),
        ));
  }

  static showAppErrorDialog(
      {required BuildContext context, Exception? exception}) {
    showDialog(
        context: context,
        builder: (context) {
          onPressed() {
            Navigator.of(context).pop();
          }

          return CupertinoAlertDialog(
            title: Text("Oops!"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                    "Something went wrong! ${kDebugMode ? exception ?? "" : ""}")
              ],
            ),
            actions: [
              // TextButton(onPressed: (){}, child: Text("Okay")),
              _getDialogButton(content: 'Ok', onTap: onPressed)
            ],
          );
        });
  }

  static showPermissionDialog(
      {required BuildContext context,
      String? title,
      String? message,
      Function()? onTapContinue,
      Function()? onTapCancel}) {
    showDialog(
        context: context,
        builder: (context) {
          onContinuePressed() {
            if (onTapContinue != null) {
              onTapContinue();
            }
            Navigator.of(context).pop();
          }

          onCancelPressed() {
            if (onTapCancel != null) {
              onTapCancel();
            }
            Navigator.of(context).pop();
          }

          return CupertinoAlertDialog(
            title: Text(title ?? "Are you sure?"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Text(message ?? "Do you want to continue?")
              ],
            ),
            actions: [
              _getDialogButton(content: "Cancel", onTap: onCancelPressed),
              _getDialogButton(content: "Continue", onTap: onContinuePressed)
            ],
          );
        });
  }

  static showCustomDialog({
    required BuildContext context,
    String? title,
    Widget? content,
    String? trueBtnTxt,
    Function()? trueBtnTap,
    String? falseBtnTxt,
    Function()? falseBtnTap

  }) {
    showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: Text(title ?? ''),
              content: content,
              actions: [
                if(falseBtnTap!=null||falseBtnTxt!=null)
                    _getDialogButton(content: falseBtnTxt??'cancel', onTap: (){
                      if(falseBtnTap!=null)
                        {
                          falseBtnTap();
                        }
                      Navigator.of(context).pop();
                    })
                  ,
                _getDialogButton(
                    content: trueBtnTxt ?? 'ok',
                    onTap: () {
                      if (trueBtnTap != null) {
                        trueBtnTap();
                      }
                      Navigator.of(context).pop();
                    })
              ],
            ));
  }
}
