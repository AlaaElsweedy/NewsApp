import 'package:flutter/material.dart';

class WHATSNEW extends StatefulWidget {
  @override
  _WHATSNEWState createState() => _WHATSNEWState();
}

class _WHATSNEWState extends State<WHATSNEW> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _drawHeader(),
          _topStories(),
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

  Widget _topStories() {
    return Container(
      color: Colors.grey.shade300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 20, left: 20, bottom: 15),
            child: _drawTitle('Top Stories'),
          ),
          Padding(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Card(
              elevation: 2,
              child: Column(
                children: <Widget>[
                  _singleCard(),
                  _cardDivider(),
                  _singleCard(),
                  _cardDivider(),
                  _singleCard(),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20, left: 20, bottom: 15),
            child: _drawTitle('Recent Updates'),
          ),
          Padding(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Column(
              children: <Widget>[
                _drawUpdatesCard(Colors.deepOrange, 'Verttel is ferrari number one'),
                _drawUpdatesCard(Colors.lime.shade600, 'The city in Pakistan that loves'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _singleCard() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            width: 130,
            height: 130,
            child: Image.asset('assets/images/body-bg.jpg'),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              children: <Widget>[
                Text(
                  'The world global warming annual summit',
                  style: TextStyle(
                      color: Colors.black87, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Row(
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
                          '15 min',
                          style: TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
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

  Widget _drawUpdatesCard(Color color, String text) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.30,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: ExactAssetImage('assets/images/body-bg.jpg'),
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
            child: Text(text,
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
                  '15 min',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
