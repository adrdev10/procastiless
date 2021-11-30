import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:procastiless/components/project/screen/newproject.dart';

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
            return NewProject();
          }));
        },
        child: Container(
          width: 130,
          height: 130,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  colors: [Color(0xff243C51), Color(0xff243C51)])),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ));
  }
}
