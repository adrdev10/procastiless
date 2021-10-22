import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddProjectButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        highlightElevation: 500,
        autofocus: true,
        elevation: 200,
        mini: true,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Container();
          }));
        },
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  colors: [Color(0xff7E33B8), Color(0xffEE5A3A)])),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ));
  }
}
