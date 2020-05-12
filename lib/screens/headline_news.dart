import 'package:flutter/material.dart';
import 'package:news_app/home_tabs/favourite.dart';
import 'package:news_app/home_tabs/popular.dart';
import 'package:news_app/home_tabs/whatsnew.dart';
import 'package:news_app/shared_ui/navigation_drawer.dart';


class HeadlineNews extends StatefulWidget {
  @override
  _HeadlineNewsState createState() => _HeadlineNewsState();
}

class _HeadlineNewsState extends State<HeadlineNews> with SingleTickerProviderStateMixin{

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: AppBar(
        title: Text('Headline News'),
        bottom: TabBar(
          indicatorColor: Colors.white,
          tabs: [
            Tab(
              text: "WHAT'S NEW",
            ),
            Tab(
              text: "POPULAR",
            ),
            Tab(
              text: "FAVOURITE",
            ),
          ],
          controller: _tabController,
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: TabBarView(
          children: [FaVOURITE(), POPULAR(), FaVOURITE()],
          controller: _tabController,
        ),
      ),
    );
  }
}
