import 'package:com.newsfeed.app/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../blocs/NewsBloc.dart';
import '../../models/article_model.dart';
import '../../widgets/news_card.dart';
import '../../widgets/wrap_widgets.dart';
import '../news/news_screen.dart';
class SearchTab extends StatefulWidget {
  const SearchTab({Key? key}) : super(key: key);

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  TextEditingController searchController = TextEditingController();

  // late final SearchBloc searchBloc;
  late final NewsBloc newsBloc ;
  int selectedContainerIndex = -1;
  List<String> customNames = [
    'All',
    'Politics',
    'Sports',
    'Education',
    'Gaming',
  ];

  @override
  void initState() {
    super.initState();
    newsBloc = BlocProvider.of<NewsBloc>(context);
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Discover",
            style: TextStyle(
                fontSize: 35,
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

          TextFormField(
            controller: searchController,
            maxLines:  1,


            decoration: InputDecoration(

                labelStyle: TextStyle(fontSize: 16.sp),
                labelText: "Search",
                hintText: "Write the keyword and tap the search icon",
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                filled: true,
                fillColor: Colors.blueAccent.shade200.withOpacity(0.1),
                suffixIconConstraints: BoxConstraints.tight(Size.square(35.sp)),
                suffixIcon: GestureDetector(
                  onTap: (){
                    String keyword = searchController.text;
                    newsBloc.searchKeyword(keyword);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 9),
                    child: SvgPicture.asset("assets/interface/search.svg",color: Colors.blueAccent.withOpacity(0.9),height: 5.sp,),
                  ),
                )
            ),
          ),

          SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: List.generate(customNames.length, (index) {
                return SelectableContainer(
                  index: index,
                  isSelected: selectedContainerIndex == index,
                  customName: customNames[index],
                  onTap: () {
                    setState(() {
                      selectedContainerIndex = index;
                    });
                  },
                );
              }),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Container(
              height: 500.h,
              child: BlocBuilder<NewsBloc, List<Article>>(
                  builder: (context, articles) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: articles.length,
                        itemBuilder: (context, index) {
                          final article = articles[index];
                          return NewsCard(
                            article: article,
                          );
                        });
                  }),
            ),
          )
        ],
      ),
    );
  }
}
