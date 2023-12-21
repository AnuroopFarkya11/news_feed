import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../models/article_model.dart';

class BreakingNewsCard extends StatelessWidget {
  final Article article;
  const BreakingNewsCard({Key? key,required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30)
        ),
        height: 250,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Stack(children: [
              Image.network(article.urlToImage??"https://t3.ftcdn.net/jpg/03/27/55/60/360_F_327556002_99c7QmZmwocLwF7ywQ68ChZaBry1DbtD.jpg",fit: BoxFit.cover,width: double.maxFinite,height: double.maxFinite,),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(article.author??" ", style: TextStyle(color: Colors.white, fontSize: 15),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(article.title, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
