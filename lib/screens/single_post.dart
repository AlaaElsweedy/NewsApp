import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_app/models/posts.dart';

class SinglePost extends StatefulWidget {
  final Posts posts;

  SinglePost(this.posts);

  @override
  _SinglePostState createState() => _SinglePostState();
}

class _SinglePostState extends State<SinglePost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
              expandedHeight: 300.0,
              floating: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.posts.featuredImage),
                        fit: BoxFit.cover),
                  ),
                ),
              )),
          SliverList(
            // ignore: missing_return
            delegate: SliverChildBuilderDelegate((context, index) {
              if (index == 0) {
                return _drawPostDetails();
              } else if (index >= 1 && index < 24) {
                return _comments();
              } else {
                return _commentTextEntry();
              }
            }, childCount: 25),
          ),
        ],
      ),
    );
  }

//  Color getRandomColor({int minBrightness = 50}) {
//    final random = Random();
//    assert(minBrightness >= 0 && minBrightness <= 255);
//    return Color.fromARGB(
//      0xFF,
//      minBrightness + random.nextInt(255 - minBrightness),
//      minBrightness + random.nextInt(255 - minBrightness),
//      minBrightness + random.nextInt(255 - minBrightness),
//    );
//  }

  Widget _drawPostDetails() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Text(
        widget.posts.content,
        style: TextStyle(fontSize: 18, letterSpacing: 1.2, height: 1.25),
      ),
    );
  }

  Widget _comments() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: ExactAssetImage('assets/images/body-bg.jpg'),
              ),
              SizedBox(width: 16,),
              Column(
                children: <Widget>[
                  Text('Christina'),
                  Text('1 hour'),
                ],
              ),
            ],
          ),
          SizedBox(height: 16,),
          Text('Weasel the jeeper goodness inconsiderately spelled so ubiquitous amused knitted and altruistic amiable...'),
        ],
      ),
    );
  }

  Widget _commentTextEntry() {
    return Container(
      color: Color.fromRGBO(241, 245, 247, 1),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Write Comment here!',
                ),
              ),
            ),
            FlatButton(
              child: Text(
                'SEND',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
