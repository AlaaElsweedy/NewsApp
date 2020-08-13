import 'package:flutter/material.dart';
import 'package:page_view_indicator/page_view_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:news_app/models/pagemodel.dart';
import 'home_screen.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  List<PageModel> pages;

  void _addPages() {
    pages = List<PageModel>();
    pages.add(PageModel(
        'Welcome',
        '1- Making friends is easy as waving your hand back and forth in easy step',
        Icons.ac_unit,
        'assets/images/groot.jpg'));
    pages.add(PageModel(
        'Alarm',
        '2- Making friends is easy as waving your hand back and forth in easy step',
        Icons.access_alarms,
        'assets/images/groot2.jpg'));
    pages.add(PageModel(
        'Print',
        '3- Making friends is easy as waving your hand back and forth in easy step',
        Icons.map,
        'assets/images/groot3.jpg'));
    pages.add(PageModel(
        'Map',
        '4- Making friends is easy as waving your hand back and forth in easy step',
        Icons.ac_unit,
        'assets/images/groot4.jpg'));
  }

  @override
  Widget build(BuildContext context) {
    _addPages();

    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView.builder(
            itemBuilder: (context, index) {
              return Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: ExactAssetImage(pages[index].image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //دي للمحتوي اللي فيه
                    crossAxisAlignment: CrossAxisAlignment.center,
                    //دي لل widget التانية
                    children: <Widget>[
                      Transform.translate(
                        child: Icon(
                          pages[index].icon,
                          color: Colors.white,
                          size: 150,
                        ),
                        offset: Offset(0, -100),
                      ),
                      Text(
                        pages[index].title,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 40, right: 40, top: 10),
                        child: Text(
                          pages[index].description,
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
            itemCount: pages.length,
            onPageChanged: (index) {
              _pageIndexNotifier.value = index;
            },
          ),
          Transform.translate(
            offset: Offset(0, 150),
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _displayCircleIndicator(),
                ],
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: RaisedButton(
                  color: Colors.red.shade800,
                  child: Text(
                    "GET STARTED",
                    style: TextStyle(color: Colors.white, letterSpacing: 1),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          _updateSeen();
                          return HomeScreen();
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawCircle(Color color) {
    return Container(
      margin: EdgeInsets.only(right: 5),
      width: 15,
      height: 15,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }

  Widget _displayCircleIndicator() {
    return PageViewIndicator(
      pageIndexNotifier: _pageIndexNotifier,
      length: pages.length,
      normalBuilder: (animationController, index) => Circle(
        size: 8.0,
        color: Colors.grey,
      ),
      highlightedBuilder: (animationController, index) => ScaleTransition(
        scale: CurvedAnimation(
          parent: animationController,
          curve: Curves.ease,
        ),
        child: Circle(
          size: 12.0,
          color: Colors.red,
        ),
      ),
    );
  }

  ValueNotifier<int> _pageIndexNotifier = ValueNotifier(0);

  void _updateSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('seen', true);
  }
}
