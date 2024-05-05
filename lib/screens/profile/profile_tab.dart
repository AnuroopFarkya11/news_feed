import 'dart:developer';

import 'package:com.newsfeed.app/blocs/NewsBloc.dart';
import 'package:com.newsfeed.app/constants/brand_asset_constants.dart';
import 'package:com.newsfeed.app/constants/brand_color_constants.dart';
import 'package:com.newsfeed.app/constants/brand_constants.dart';
import 'package:com.newsfeed.app/constants/brand_text_constants.dart';
import 'package:com.newsfeed.app/routes/route_path.dart';
import 'package:com.newsfeed.app/screens/auth/login/login_screen.dart';
import 'package:com.newsfeed.app/services/database/sql_base.dart';
import 'package:com.newsfeed.app/services/firebase_service/firebase_auth.dart';
import 'package:com.newsfeed.app/services/ota/ota_manager.dart';
import 'package:com.newsfeed.app/utils/app_utils.dart';
import 'package:com.newsfeed.app/widgets/app_dialog_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:ota_update/ota_update.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String state = '';
  List<Map<String, dynamic>> filteredCountries = BrandTextConstant.countries;



  @override
  Widget build(BuildContext context) {


    print("called");
    return Column(
      children: [
        SizedBox(height: 0.0),
        CircleAvatar(
          radius: 50.0,
          backgroundImage: NetworkImage(BrandAsset.userImage),
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
                  buildProfileOption(
                      context, BrandTextConstant.editProfile, Icons.edit, () {
                    // Navigate to Edit Profile screen
                  }),
                  buildProfileOption(
                      context, BrandTextConstant.changePassword, Icons.lock,
                      () {
                    // Navigate to Change Password screen
                  }),
                  buildProfileOption(
                      context,
                      BrandTextConstant.subscriptionStatus,
                      Icons.subscriptions, () {
                    // Navigate to Subscription Status screen
                  }),
                  buildProfileOption(
                      context, BrandTextConstant.preferences, Icons.settings,
                      () {
                    // Navigate to Preferences screen
                  }),
                  buildProfileOption(
                      context, "Your Published Articles", Icons.bookmark,
                      () {
                    Navigator.pushNamed(context, RoutePath.customNews);
                  }),
                  buildProfileOption(context, BrandTextConstant.logout,
                      Icons.logout, onLogoutTapped),
                  buildProfileOption(
                      context, BrandTextConstant.settings, Icons.settings, () {
                    // Navigate to Settings screen
                  }),
                  buildProfileOption(
                      context, BrandTextConstant.feedbackRating, Icons.feedback,
                      () {
                    // Navigate to Feedback/Rating screen
                  }),
                  buildProfileOption(
                      context, 'Change origin', Icons.auto_awesome, () {
                    filteredCountries = BrandTextConstant.countries;

                    AppDialogBox.showCustomDialog(
                        context: context,
                        title: "Select origin",
                        content: StatefulBuilder(
                          builder: (BuildContext context,
                              void Function(void Function()) setState) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 10.h,
                                ),
                                CupertinoTextField(
                                  decoration: BoxDecoration(),
                                  placeholder: 'Search Country',
                                  prefix: Icon(Icons.search),
                                  onChanged: (String value) {
                                    print("Changed called");
                                    setState(() {
                                      if (value.isEmpty) {
                                        filteredCountries =
                                            BrandTextConstant.countries;
                                      }
                                      print("$value");
                                      filteredCountries =
                                          BrandTextConstant.countries
                                              .where((country) =>
                                              country['name']
                                                  .toLowerCase()
                                                  .contains(value
                                                  .toLowerCase()))
                                              .toList();

                                      print(
                                          "filter list length : ${filteredCountries.length}");
                                    });
                                  },
                                ),
                                filteredCountries.length != 0
                                    ? SingleChildScrollView(
                                  child: Column(
                                    children: List.generate(
                                        filteredCountries.length,
                                            (index) =>
                                            CupertinoListTile(
                                                onTap: () async {
                                                  Navigator.of(
                                                      context)
                                                      .pop();
                                                  String
                                                  countryCode =
                                                  filteredCountries[
                                                  index]
                                                  ['code'];
                                                  try {

                                                    print("Selected country code : $countryCode");
                                                    // await DBBase.updateCountry(
                                                    //             countryCode:
                                                    //                 countryCode) >=
                                                    //         1
                                                    //     ? AppUtils.showAppSnackBar(
                                                    //         context:
                                                    //             context,
                                                    //         content:
                                                    //             'Country selected successfully!')
                                                    //     : AppUtils.showAppSnackBar(
                                                    //         context:
                                                    //             context);
                                                    AppUtils.showAppSnackBar(
                                                        context:
                                                        context,
                                                        content:
                                                        'Country selected successfully!');
                                                    BrandConstant.country = countryCode;

                                                    await BlocProvider.of<
                                                        NewsBloc>(
                                                        context)
                                                        .getHeadlineNews();

                                                  } on Exception catch (e) {
                                                    log("Profile tab exception : $e");
                                                  }
                                                  // print('$country');
                                                },
                                                leading: Text(
                                                    '${filteredCountries[index]['flag']}'),
                                                title: Text(
                                                    '${filteredCountries[index]['name']}'))),
                                  ),
                                )
                                    : Lottie.asset(
                                    'assets/animation/empty.json')
                              ],
                            );
                          },
                        ));
                  }),
                  buildProfileOption(
                      context, BrandTextConstant.aboutUs, Icons.info, () {

                  }),
                  Visibility(
                    visible: kDebugMode,
                    child: Column(
                      children: [
                        const Divider(),
                        buildProfileOption(context,
                            BrandTextConstant.cleanDatabase, Icons.delete, () {
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
                            context,
                            BrandTextConstant.checkForUpdate,
                            Icons.update, () async {
                          try {
                            Stream<OtaEvent>? stream =
                                await OTAManager().tryOtaUpdate();
                            if (stream != null) {
                              AppDialogBox.showCustomDialog(
                                  context: context,
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CupertinoActivityIndicator(radius: 15.r),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      StreamBuilder(
                                          stream: stream,
                                          builder: (context, snapshot) {
                                            print("${snapshot.data?.value}");
                                            return Text(
                                                "${snapshot.data?.status ?? ''}  ${snapshot.data?.value ?? '0'}");
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
                        }),

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

  /// On taps
  onLogoutTapped() {
    AppDialogBox.showPermissionDialog(
        context: context,
        title: "Logout?",
        onTapContinue: () async {
          try {
            Navigator.pop(context);
            await Authentication().logout();
          } on Exception catch (e) {
            AppDialogBox.showAppErrorDialog(context: context, exception: e);
          }
        });
  }
}
