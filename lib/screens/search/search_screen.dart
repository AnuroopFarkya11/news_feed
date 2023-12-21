import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../widgets/news_card.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: Container(
        margin: EdgeInsets.symmetric(vertical: 7.h, horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Discover",
              style: TextStyle(
                  fontSize: 35,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'News from all around the world',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(
              height: 23,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Color(0xffF6F6F7),
                  borderRadius: BorderRadius.circular(30)),
              margin: EdgeInsets.only(right: 22),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                    fillColor: Color(0xffF6F6F7),
                    border: InputBorder.none,
                    hintText: "Search",
                    suffixIcon: Icon(Icons.list_alt),
                    prefixIcon: Icon(Icons.search)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                direction: Axis.horizontal,
                spacing: 10,
                children: [
                  Container(
                    height: 45,
                    width: 60,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                        child: Text(
                      'All',
                      style: TextStyle(
                          fontFamily: "inter",
                          color: Colors.white,
                          fontSize: 15),
                    )),
                  ),
                  Container(
                    height: 45,
                    width: 72,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                        child: Text(
                      'Politic',
                      style: TextStyle(
                          fontFamily: "inter",
                          color: Colors.white,
                          fontSize: 15),
                    )),
                  ),
                  Container(
                    height: 45,
                    width: 72,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                        child: Text(
                      'Sports',
                      style: TextStyle(
                          fontFamily: "inter",
                          color: Colors.white,
                          fontSize: 15),
                    )),
                  ),
                  Container(
                    height: 45,
                    width: 95,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                        child: Text(
                      'Education',
                      style: TextStyle(
                          fontFamily: "inter",
                          color: Colors.white,
                          fontSize: 15),
                    )),
                  ),
                  Container(
                    height: 45,
                    width: 65,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                        child: Text(
                      'Gaming',
                      style: TextStyle(
                          fontFamily: "inter",
                          color: Colors.white,
                          fontSize: 15),
                    )),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return NewsCard();
                },
                itemCount: 10,
              ),
            )
          ],
        ),
      ),
    );
  }
}
