import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:netflix_clone/Controllers/controller.dart';
import 'package:netflix_clone/data/data.dart';

import '../Widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late ScrollController _scrollController;
  late double _scrollOffset;
  final Controller controller = Get.put(Controller());

  @override
  void initState(){
    _scrollController = ScrollController()
        ..addListener(() {
          controller.setScroolOffset(_scrollController.offset);
        });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size(size.width, 50),
        child: GetBuilder<Controller>(
            builder: (_){
              return CustomAppBar(scrollOffset: controller.scrollOffsetGet.toDouble());
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          print('Cast');
        },
        backgroundColor: Colors.grey[850],
        child: const Icon(Icons.cast),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: ContentHeader(featuredContent: sintelContent),
          ),
          SliverPadding(
              padding: const EdgeInsets.only(top: 20),
          sliver: SliverToBoxAdapter(
            key: const PageStorageKey('previews'),
            child: Previews(
              title: "Previews",
              contentList: previews
            ),
          ),
          ),
          SliverToBoxAdapter(
            key: const PageStorageKey('myList'),
            child: ContentList(
              title:'My List',
              contentList: myList
            ),
          ),
          SliverToBoxAdapter(
            key: const PageStorageKey('originals'),
            child: ContentList(
                title:'Netflix Originals',
                contentList: originals,
              isOriginals: true
            ),
          ),
          SliverPadding(
              padding: const EdgeInsets.only(bottom: 20),
            sliver: SliverToBoxAdapter(
              key: const PageStorageKey('trending'),
              child: ContentList(
                  title:'Trending',
                  contentList: trending
              ),
            ),
          ),
        ],
      ),

    );
  }
}
