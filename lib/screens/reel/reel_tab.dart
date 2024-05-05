import 'package:com.newsfeed.app/blocs/hmmBloc.dart';
import 'package:com.newsfeed.app/screens/home/ui/home_tab.dart';
import 'package:com.newsfeed.app/screens/reel/widget/reel_widget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReelTab extends StatefulWidget {
  ReelTab({super.key});

  @override
  State<ReelTab> createState() => _ReelTabState();
}

class _ReelTabState extends State<ReelTab> {

  @override
  Widget build(BuildContext context) {


    return BlocBuilder<ReelBloc,AsyncSnapshot>(
        builder: (context,snapshot){



      return  PageView.builder(
        itemCount: snapshot.data == null ? 0 : snapshot.data!.docs.length,
        scrollDirection: Axis.vertical,
        controller: PageController(initialPage: 0, viewportFraction: 1),
        itemBuilder:  (context, index) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          return ReelsItem(snapshot.data!.docs[index].data());
        },
      );

    });


  }
}
