import 'package:com.newsfeed.app/constants/brand_asset_constants.dart';
import 'package:com.newsfeed.app/constants/brand_color_constants.dart';
import 'package:com.newsfeed.app/constants/brand_style_constants.dart';
import 'package:com.newsfeed.app/constants/brand_text_constants.dart';
import 'package:com.newsfeed.app/screens/add_news/widget/add_news_header.dart';
import 'package:com.newsfeed.app/services/database/sql_base.dart';
import 'package:com.newsfeed.app/utils/app_utils.dart';
import 'package:com.newsfeed.app/widgets/app_dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:com.newsfeed.app/screens/news/widget/news_header.dart';
import 'package:screenshot/screenshot.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/article_model.dart';

class AddNewsPage extends StatefulWidget {
  AddNewsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AddNewsPage> createState() => _AddNewsPageState();
}

class _AddNewsPageState extends State<AddNewsPage> {
  // late String newsDetails =
  //     article?.description ?? BrandTextConstant.description;
  TextEditingController _headingTextFieldController = TextEditingController();
  TextEditingController _authorTextFieldController = TextEditingController();
  TextEditingController _descriptionTextFieldController =
      TextEditingController();
  TextEditingController _sourceNameTextFieldController =
      TextEditingController();
  TextEditingController _sourceUrlTextFieldController = TextEditingController();
  bool isContinueLoading = false;

  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
    _headingTextFieldController.clear();
    _authorTextFieldController.clear();
    _descriptionTextFieldController.clear();
    _sourceNameTextFieldController.clear();
    _sourceUrlTextFieldController.clear();
  }

  @override
  Widget build(BuildContext context) {
    // _initArticle();
    // DateTime dateTime =
    // DateTime.parse(article?.publishedAt ?? DateTime.now().toString());

    return Scaffold(
        backgroundColor: Colors.black,
        body:
            CustomScrollView(physics: NeverScrollableScrollPhysics(), slivers: [
          AddNewsHeader(),
          SliverFillRemaining(
              child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.r),
                        topRight: Radius.circular(20.r)),
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          Form(
                            child: Column(
                              children: [
                                _getTextField(
                                    _headingTextFieldController, "Heading"),
                                SizedBox(
                                  height: 20.h,
                                ),
                                _getTextField(
                                    _authorTextFieldController, "Author Name"),
                                SizedBox(
                                  height: 20.h,
                                ),
                                _getTextField(_descriptionTextFieldController,
                                    "Description",
                                    maxLines: 8),
                                SizedBox(
                                  height: 20.h,
                                ),
                                _getTextField(_sourceNameTextFieldController,
                                    "Source Name",
                                    maxLines: 1),
                                SizedBox(
                                  height: 20.h,
                                ),
                                _getTextField(
                                    _sourceUrlTextFieldController, "Source Url",
                                    maxLines: 1),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          ElevatedButton(
                            onPressed: onContinueTap,
                            child: isContinueLoading == false
                                ? Text(
                                    "Continue",
                                    style: TextStyle(color: Colors.white),
                                  )
                                : CircularProgressIndicator(),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: BrandColors.brandColor),
                          )
                        ]),
                  )))
        ]));
  }

  _getTextField(TextEditingController controller, String labelText,
      {int? maxLines}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines ?? 1,
      decoration: InputDecoration(
        labelStyle: TextStyle(fontSize: 12.sp),
        labelText: labelText,
        hintText: '',
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(20.0),
        ),
        filled: true,
        fillColor: Colors.blueAccent.shade200.withOpacity(0.1),
      ),
    );
  }

  void onContinueTap() async {
    setState(() {
      isContinueLoading = true;
    });
    Future.delayed(Duration(seconds: 2));
    try {
      Article article = Article(
          source: _sourceNameTextFieldController.text ??
              BrandTextConstant.googleDomain,
          title: _headingTextFieldController.text ?? "Breaking news",
          url: _sourceUrlTextFieldController.text ??
              BrandTextConstant.googleDomain,
          publishedAt: "",
          urlToImage: BrandAsset.imageURl,
          content: _descriptionTextFieldController.text,
          author: _authorTextFieldController.text,
          description: _descriptionTextFieldController.text,
      );

      await DBBase.insertCustomArticle(article.toJson())
          .then((value) {
        print("News published res : $value");
        value >= 1
            ? AppUtils.showAppSnackBar(
            context: context, content: 'News published successfully!')
            : AppUtils.showAppSnackBar(context: context);

        Navigator.of(context).pop();
      });
    } on Exception catch (e) {
      AppDialogBox.showAppErrorDialog(context: context,exception: e,onTap: (){
        Navigator.pop(context);
      });
    }
    setState(() {
      isContinueLoading = false;
    });
  }
}

/*
*
* NewsPageHeader(
                  title: article.title ?? 'Breaking News',
                  imageAssetPath: article.urlToImage ??
                      "https://t3.ftcdn.net/jpg/03/27/55/60/360_F_327556002_99c7QmZmwocLwF7ywQ68ChZaBry1DbtD.jpg",
                  category: "News",
                  date: dateTime,
                  minExtent: topPadding + 56,
                  maxExtent: maxScreenSize / 2)
*
* */
