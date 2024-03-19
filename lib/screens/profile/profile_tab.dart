import 'package:NewsFeed/constants/brand_asset_constants.dart';
import 'package:NewsFeed/constants/brand_text_constants.dart';
import 'package:NewsFeed/services/database/sql_base.dart';
import 'package:NewsFeed/services/ota/ota_manager.dart';
import 'package:NewsFeed/widgets/app_dialog_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ota_update/ota_update.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String state = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 0.0),
        CircleAvatar(
          radius: 50.0,
          backgroundImage: NetworkImage(
              BrandAsset.userImage),
        ),
        SizedBox(height: 16.0),
        Text(
          BrandTextConstant.profileName,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          BrandTextConstant.email,
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 24.0),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildProfileOption(context, BrandTextConstant.editProfile, Icons.edit, () {
                    // Navigate to Edit Profile screen
                  }),
                  buildProfileOption(context, BrandTextConstant.changePassword, Icons.lock,
                          () {
                        // Navigate to Change Password screen
                      }),
                  buildProfileOption(
                      context, BrandTextConstant.subscriptionStatus, Icons.subscriptions, () {
                    // Navigate to Subscription Status screen
                  }),
                  buildProfileOption(context, BrandTextConstant.preferences, Icons.settings,
                          () {
                        // Navigate to Preferences screen
                      }),
                  buildProfileOption(context, BrandTextConstant.savedArticles, Icons.bookmark,
                          () {
                        // Navigate to Saved Articles screen
                      }),
                  buildProfileOption(context, BrandTextConstant.logout, Icons.logout, () {
                    // Perform logout action
                  }),
                  buildProfileOption(context, BrandTextConstant.settings, Icons.settings, () {
                    // Navigate to Settings screen
                  }),
                  buildProfileOption(context, BrandTextConstant.feedbackRating, Icons.feedback,
                          () {
                        // Navigate to Feedback/Rating screen
                      }),
                  buildProfileOption(context, BrandTextConstant.aboutUs, Icons.info, () {
                    // Navigate to About Us screen
                  }),
                  Visibility(
                    visible: kDebugMode,
                    child: Column(
                      children: [
                        const Divider(),
                        buildProfileOption(
                            context, BrandTextConstant.cleanDatabase, Icons.delete, () {
                          // AppDialogBox.showAppErrorDialog(context: context,);
                          AppDialogBox.showPermissionDialog(
                            context: context,
                            message: BrandTextConstant.cleanDatabaseMessage,
                            onTapContinue: () async {
                              try {
                                await DBBase.cleanDatabase();
                              } on Exception catch (e) {
                                AppDialogBox.showAppErrorDialog(
                                    context: context, exception: e);
                              }
                            },
                          );
                        }),
                        buildProfileOption(
                            context, BrandTextConstant.checkForUpdate, Icons.update,
                                () async {
                              try {
                                Stream<OtaEvent>? stream =
                                await OTAManager().tryOtaUpdate();
                                if (stream != null) {
                                  AppDialogBox.showCustomDialog(
                                      context: context,
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CupertinoActivityIndicator(
                                              radius: 15.r),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          StreamBuilder(stream: stream, builder: (context,snapshot){

                                            return Text("${snapshot.data?.status??''}  ${snapshot.data?.value??'0'}");
                                          })
                                        ],
                                      ),
                                      trueBtnTxt: 'Cancel');


                                } else {
                                  throw Exception("Stream is null");
                                }
                              } catch (e) {
                                AppDialogBox.showAppErrorDialog(
                                    context: context, exception: Exception(e));
                              }
                            })
                      ],
                    ),
                  ),
                  SizedBox(height: 24.0),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildProfileOption(
      BuildContext context, String title, IconData icon, Function onTap) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0),
        child: Row(
          children: [
            Icon(
              icon,
              size: 28.0,
              color: Colors.blueAccent,
            ),
            SizedBox(width: 16.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
