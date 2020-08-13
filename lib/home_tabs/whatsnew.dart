import 'dart:math';
import 'package:flutter/material.dart';
import 'package:news_app/api/posts_api.dart';
import 'package:news_app/models/posts.dart';
import 'package:news_app/screens/single_post.dart';
import 'package:news_app/utilities/data_utilities.dart';

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
    return FutureBuilder(
      future: postsApi.fetchPostsCategoriesById("1"),
      // ignore: missing_return
      builder: (context, AsyncSnapshot snapShot) {
        switch (snapShot.connectionState) {
          case ConnectionState.none:
            return connectionError();
            break;
          case ConnectionState.active:
            return loading();
            break;
          case ConnectionState.waiting:
            return loading();
            break;
          case ConnectionState.done:
            if (snapShot.hasError) {
              return error(snapShot.error);
            } else {
              List<Posts> post = snapShot.data;
              Random random = Random();
              int indexRandom = random.nextInt(post.length);
              Posts posts = post[indexRandom];
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SinglePost(posts);
                  }));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.25,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(posts.featuredImage),
                        fit: BoxFit.cover),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        posts.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 4, left: 40, right: 40),
                        child: Text(
                          posts.content.substring(0, 75),
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            break;
        }
      },
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
                future: postsApi.fetchPostsCategoriesById("1"),
                // ignore: missing_return
                builder: (context, AsyncSnapshot snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState
                        .waiting: // لسه مبعدش للسيرفر لسه عملية الاتصال بالانترنت ممكن متكنش اساسا كملت
                      // بيجاول ياخد صلاحيات الاتصال بالانترنت
                      return loading();
                      break;
                    case ConnectionState.active: // تم الاتصال بالانترنت وال api
                      return loading();
                      break;
                    case ConnectionState
                        .none: // فيه حاجة غلط زي مثلا مفيش انترنت
                      return connectionError();
                      break;
                    case ConnectionState
                        .done: // هنا مش معناه ان معايا بيانات القصد هنا ان عملية الطلب والجواب تمت
                      if (snapshot.error != null) {
                        return error(snapshot.error);
                      } else {
                        if (snapshot.hasData) {
                          List<Posts> postsLength = snapshot.data;
                          if (postsLength.length >= 3) {
                            Posts posts1 = snapshot.data[0];
                            Posts posts2 = snapshot.data[1];
                            Posts posts3 = snapshot.data[2];
                            return Column(
                              children: <Widget>[
                                _singleCard(posts1),
                                _cardDivider(),
                                _singleCard(posts2),
                                _cardDivider(),
                                _singleCard(posts3),
                              ],
                            );
                          } else {
                            return noData();
                          }
                        } else {
                          return noData();
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
        future: postsApi.fetchPostsCategoriesById("2"),
        // ignore: missing_return
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return connectionError();
              break;
            case ConnectionState.active:
              return loading();
              break;
            case ConnectionState.waiting:
              return loading();
              break;
            case ConnectionState.done:
              if (snapshot.hasError) {
                return error(snapshot.error);
              } else {
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

  Widget _singleCard(Posts posts) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return SinglePost(posts);
        }));
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: 130,
              height: 130,
              child: Image.network(
                posts.featuredImage,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                children: <Widget>[
                  Text(
                    posts.title,
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
                              parseHumanDateTime(posts.dateWritten),
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
      ),
    );
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
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return SinglePost(posts);
        }));
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.30,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(posts.featuredImage), fit: BoxFit.cover),
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
                    parseHumanDateTime(posts.dateWritten),
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
