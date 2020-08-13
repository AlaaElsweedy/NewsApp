import 'package:flutter/material.dart';
import 'package:news_app/shared_ui/navigation_drawer.dart';

class InstagramFeed extends StatefulWidget {
  @override
  _InstagramFeedState createState() => _InstagramFeedState();
}

class _InstagramFeedState extends State<InstagramFeed> {

  List<int> ids = [];

  TextStyle _hashTagsStyle = TextStyle(
    color: Colors.orange
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
        ],
        title: Text('Instagram Feeds'),
      ),
      drawer: NavigationDrawer(),
      body: ListView.builder(
        itemBuilder: (context, position) {
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _drawHeader(position),
                _drawTitle(),
                _drawHashTags(),
                _drawBody(),
                _drawFooter(),
              ],
            ),
          );
        },
        itemCount: 20,
      ),
    );
  }

  Widget _drawHeader(int position) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CircleAvatar(
                backgroundImage: ExactAssetImage('assets/images/body-bg.jpg'),
                radius: 24,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Christina Meyers'),
                SizedBox(
                  height: 8,
                ),
                Text('Fri, 12 May 2017 * 14.30'),
              ],
            ),
          ],
        ),
        Row(
          children: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: (ids.contains(position) ? Colors.red : Colors.grey.shade400),
                ),
                onPressed: () {
                  if(ids.contains(position)){
                    ids.remove(position);
                  }else{
                    ids.add(position);
                  }
                  setState(() {

                  });
                }),
            Transform.translate(
              offset: Offset(-12, 0),
              child: Text(
                '25',
                style: TextStyle(color: Colors.grey.shade400, fontSize: 16),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _drawTitle() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 16, right: 16),
      child: Text(
        'We also talk about future of work as robots',
        style: TextStyle(color: Colors.grey.shade900),
      ),
    );
  }

  Widget _drawBody() {
    return SizedBox(
      width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.40,
        child: Image(
      image: ExactAssetImage('assets/images/body-bg.jpg'),
      fit: BoxFit.cover,
    ));
  }

  Widget _drawFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FlatButton(onPressed: (){}, child: Text('10COMMENTS', style: _hashTagsStyle,)),
        Row(
          children: <Widget>[
            FlatButton(onPressed: (){}, child: Text('SHARE', style: _hashTagsStyle,)),
            FlatButton(onPressed: (){}, child: Text('OPEN', style: _hashTagsStyle,)),
          ],
        ),
      ],
    );
  }

  Widget _drawHashTags() {
    return Container(
      child: Wrap(
        children: <Widget>[
          FlatButton(
            onPressed: () {},
            child: Text(
              '#advance',
              style: _hashTagsStyle,
            ),
          ),
          FlatButton(
            onPressed: () {},
            child: Text(
              '#advance',
              style: _hashTagsStyle,
            ),
          ),
          FlatButton(
            onPressed: () {},
            child: Text(
              '#advance',
              style: _hashTagsStyle,
            ),
          ),
        ],
      ),
    );
  }
}
