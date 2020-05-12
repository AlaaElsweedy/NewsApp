import 'package:flutter/material.dart';

class FaVOURITE extends StatefulWidget {
  @override
  _FaVOURITEState createState() => _FaVOURITEState();
}

class _FaVOURITEState extends State<FaVOURITE> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, position) {
        return Card(
          child: Container(
            child: Column(
              children: <Widget>[
                _authorRow(),
                _newItwm(),
              ],
            ),
          ),
        );
      },
      itemCount: 20,
    );
  }

  Widget _authorRow(){

  }

  Widget _newItwm(){

  }
}
