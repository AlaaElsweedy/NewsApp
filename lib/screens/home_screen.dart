import 'package:flutter/material.dart';
import 'package:news_app/shared_ui/navigation_drawer.dart';
import 'package:news_app/home_tabs/favourite.dart';
import 'package:news_app/home_tabs/popular.dart';
import 'package:news_app/home_tabs/whatsnew.dart';
import 'pages/about_us.dart';
import 'pages/settings.dart';
import 'pages/contact.dart';
import 'pages/help.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

enum PopOutMenu { HELP, ABOUT, CONTACT, SETTINGS }

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: AppBar(
        title: Text('Explore'),
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
          _popOutMenu(context),
        ],
      ),
      body: Center(
        child: TabBarView(
          children: [WHATSNEW(), POPULAR(), FaVOURITE()],
          controller: _tabController,
        ),
      ),
    );
  }

  Widget _popOutMenu(BuildContext context) {
    return PopupMenuButton<PopOutMenu>(
      itemBuilder: (context) {
        return [
          PopupMenuItem<PopOutMenu>(
            value: PopOutMenu.ABOUT,
            child: Text('ABOUT'),
          ),
          PopupMenuItem<PopOutMenu>(
            value: PopOutMenu.CONTACT,
            child: Text('CONTACT'),
          ),
          PopupMenuItem<PopOutMenu>(
            value: PopOutMenu.HELP,
            child: Text('HELP'),
          ),
          PopupMenuItem<PopOutMenu>(
            value: PopOutMenu.SETTINGS,
            child: Text('SETTINGS'),
          ),
        ];
      },
      onSelected: (PopOutMenu menu) {
        switch (menu) {
          case PopOutMenu.ABOUT:
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return AboutUs();
            }));
            break;
          case PopOutMenu.CONTACT:
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Contact();
            }));
            break;
          case PopOutMenu.SETTINGS:
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Settings();
            }));
            break;
          case PopOutMenu.HELP:
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Help();
            }));
            break;
        }
      },
    );
  }
}
