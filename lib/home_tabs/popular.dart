import 'package:flutter/material.dart';

class POPULAR extends StatefulWidget {
  @override
  _POPULARState createState() => _POPULARState();
}

class _POPULARState extends State<POPULAR> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, position) {
        return Card(
          child: _singleCard(),
        );
      },
      itemCount: 20,
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
}
