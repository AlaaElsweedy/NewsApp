import 'dart:math';

import 'package:flutter/material.dart';

class FaVOURITE extends StatefulWidget {
  @override
  _FaVOURITEState createState() => _FaVOURITEState();
}

class _FaVOURITEState extends State<FaVOURITE> {
  List<Color> _listColors = [
    Colors.lime,
    Colors.deepOrange,
    Colors.teal,
    Colors.blue.shade300,
    Colors.red,
    Colors.amber,
    Colors.purple
  ];

  Random _random = Random();

  Color _getRandomColor() {
    return _listColors[_random.nextInt(_listColors.length)];
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, position) {
        return Card(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                _authorRow(),
                SizedBox(
                  height: 16,
                ),
                _newItem(),
              ],
            ),
          ),
        );
      },
      itemCount: 20,
    );
  }

  Widget _authorRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: ExactAssetImage('assets/images/body-bg.jpg'),
                  fit: BoxFit.cover,
                ),
                shape: BoxShape.circle,
              ),
              width: 50,
              height: 50,
              margin: EdgeInsets.only(right: 13),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Michael Adams'),
                Row(
                  children: <Widget>[
                    Text('15 min .'),
                    Text(
                      'Lifestyle',
                      style: TextStyle(color: _getRandomColor()),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        IconButton(icon: Icon(Icons.bookmark_border), onPressed: () {}),
      ],
    );
  }

  Widget _newItem() {
    return Row(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage('assets/images/body-bg.jpg'),
            ),
          ),
          width: 130,
          height: 130,
          margin: EdgeInsets.only(right: 16),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              Text(
                'Tech Teny: Old phones and safe social',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 5,),
              Text(
                'We also talk about the future of work as the robot advance',
                style: TextStyle(color: Colors.grey, height: 1.5),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
