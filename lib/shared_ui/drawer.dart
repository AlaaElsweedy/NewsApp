import 'package:flutter/material.dart';
import 'package:news_app/models/nav_menu_item.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/screens/headline_news.dart';

class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {

  List<NavMenuItem> navigationItem = [
    NavMenuItem('Explore', () => HomeScreen()),
    NavMenuItem('Headlines', () => HeadlineNews())
  ];

//  List<String> _namesDrawer = [
//    'Explore',
//    'Heading News',
//    'Read Later',
//    'Videos',
//    'Photos',
//    'Setting',
//    'Logout'
//  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(top: 40, left: 16),
        child: ListView.builder(
          itemBuilder: (context, position) {
            return ListTile(
              title: Text(navigationItem[position].title),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return navigationItem[position].destination();
                    },
                  ),
                );
              },
            );
          },
          itemCount: navigationItem.length,
        ),
      ),
    );
  }
}
