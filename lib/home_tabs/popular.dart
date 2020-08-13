import 'package:flutter/material.dart';
import 'package:news_app/api/posts_api.dart';
import 'package:news_app/models/posts.dart';
import 'package:news_app/screens/single_post.dart';
import 'package:news_app/utilities/data_utilities.dart';

class POPULAR extends StatefulWidget {
  @override
  _POPULARState createState() => _POPULARState();
}

class _POPULARState extends State<POPULAR> {
  PostsApi postsApi = PostsApi();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: postsApi.fetchPostsCategoriesById("3"),
      // ignore: missing_return
      builder: (context, snapShot) {
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
              List<Posts> posts = snapShot.data;
              return ListView.builder(
                itemBuilder: (context, position) {
                  return Card(
                    child: _singleCard(posts[position]),
                  );
                },
                itemCount: posts.length,
              );
            }
            break;
        }
      },
    );
  }

  Widget _singleCard(Posts post) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return SinglePost(post);
          }));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: 130,
              height: 130,
              child: Image.network(post.featuredImage),
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
                              parseHumanDateTime(post.dateWritten),
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
}
