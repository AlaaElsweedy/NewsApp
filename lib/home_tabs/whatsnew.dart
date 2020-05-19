import 'package:flutter/material.dart';
import 'package:news_app/api/posts_api.dart';
import 'dart:async';
import 'package:timeago/timeago.dart' as timeago;

import 'package:news_app/models/posts.dart';

class WHATSNEW extends StatefulWidget {
  @override
  _WHATSNEWState createState() => _WHATSNEWState();
}

class _WHATSNEWState extends State<WHATSNEW> {
  PostsApi postsApi = PostsApi();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _drawHeader(),
          _drawTopStories(),
          _drawRecentUpdate()
        ],
      ),
    );
  }

  Widget _drawHeader() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: ExactAssetImage('assets/images/body-bg.jpg'),
            fit: BoxFit.cover),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'How Terriers & Royals',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 40, right: 40),
            child: Text(
              'Learn the new of news every day in the world we will help you to know every thing',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawTopStories() {
    return Container(
      color: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16),
            child: _drawTitle('Top Stories'),
          ),
          Padding(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Card(
              elevation: 2,
              child: FutureBuilder(
                future: postsApi.fetchWhatsNews(),
                // ignore: missing_return
                builder: (context, AsyncSnapshot snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState
                        .waiting: // لسه مبعدش للسيرفر لسه عملية الاتصال بالانترنت ممكن متكنش اساسا كملت
                      // بيجاول ياخد صلاحيات الاتصال بالانترنت
                      return _loading();
                      break;
                    case ConnectionState.active: // تم الاتصال بالانترنت وال api
                      return _loading();
                      break;
                    case ConnectionState.none: // فيه حاجة غلط زي مثلا مفيش انترنت
                      return _connectionError();
                      break;
                    case ConnectionState.done: // هنا مش معناه ان معايا بيانات القصد هنا ان عملية الطلب والجواب تمت
                      if (snapshot.error != null) {
                        return _error(snapshot.error);
                      } else {
                        if (snapshot.hasData) {
                          List<Posts> postsLength = snapshot.data;
                          if (postsLength.length >= 3) {
                            Posts post1 = snapshot.data[0];
                            Posts post2 = snapshot.data[1];
                            Posts post3 = snapshot.data[2];
                            return Column(
                              children: <Widget>[
                                _singleCard(post1),
                                _cardDivider(),
                                _singleCard(post2),
                                _cardDivider(),
                                _singleCard(post3),
                              ],
                            );
                          }else{
                            return _noData();
                          }
                        } else {
                          return _noData();
                        }
                      }
                      break;
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawRecentUpdate() {
    return Padding(
      padding: EdgeInsets.only(left: 5, right: 5),
      child: FutureBuilder(
        future: postsApi.fetchRecentUpdates(),
        // ignore: missing_return
        builder: (context, snapshot) {
          switch(snapshot.connectionState){
            case ConnectionState.none:
              return _connectionError();
              break;
            case ConnectionState.active:
              return _loading();
              break;
            case ConnectionState.waiting:
              return _loading();
              break;
            case ConnectionState.done:
              if(snapshot.hasError){
                return _error(snapshot.error);
              }else{
                return Column(
                  children: <Widget>[
                    _drawUpdatesCard(Colors.deepOrange, snapshot.data[0]),
                    _drawUpdatesCard(Colors.lime.shade600, snapshot.data[1]),
                  ],
                );
              }
              break;
          }

        },
      ),
    );
  }

  Widget _singleCard(Posts post) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            width: 130,
            height: 130,
            child: Image.network(
              post.featuredImage,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              children: <Widget>[
                Text(
                  post.title,
                  style: TextStyle(
                      color: Colors.black87, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Michael Adams',
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.timer,
                            color: Colors.black54,
                          ),
                          Text(
                            _parseHumanDateTime(post.dateWritten),
                            style: TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _parseHumanDateTime(String dateTime) {
    Duration timeAgo = DateTime.now().difference(DateTime.parse(dateTime));
    DateTime theDifference = DateTime.now().subtract(timeAgo);
    return timeago.format(theDifference);
  }

  Widget _cardDivider() {
    return Container(
      height: 1,
      width: double.infinity,
      color: Colors.grey.shade200,
    );
  }

  Widget _drawTitle(String title) {
    return Text(
      title,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: Colors.grey.shade600),
    );
  }

  Widget _drawUpdatesCard(Color color, Posts posts) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.30,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(posts.featuredImage),
                  fit: BoxFit.cover),
            ),
          ),
          Container(
            margin: EdgeInsets.all(8),
            alignment: Alignment.center,
            child: Text(
              'SPORT',
              style: TextStyle(color: Colors.white),
            ),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(
                Radius.circular(4),
              ),
            ),
            width: 130,
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(left: 8, bottom: 8),
            child: Text(
              posts.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 8),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.timer,
                  color: Colors.grey,
                ),
                Text(
                  _parseHumanDateTime(posts.dateWritten),
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _loading() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _connectionError() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Text('Connection error!!!'),
    );
  }

  Widget _error(var error) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Text(error.toString()),
    );
  }

  Widget _noData() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Text('No Data Available!'),
    );
  }
}
