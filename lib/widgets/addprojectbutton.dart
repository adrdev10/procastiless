import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:procastiless/components/login/bloc/login_state.dart';
import 'package:procastiless/components/project/screen/newproject.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../components/dashboard/screen/dashboardscreen.dart';

class AddProjectButton extends StatelessWidget {
  final GlobalKey _key1 = GlobalKey();
  late final List<TargetFocus> targets;
  final TutorialSettigns showTutorial;
  AddProjectButton(this.showTutorial);

  @override
  Widget build(BuildContext context) {
    targets = [
      TargetFocus(identify: "Target 1", keyTarget: _key1, contents: [
        TargetContent(
          align: ContentAlign.top,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Create Your First Project 🔥🔥🔥',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: Text(
                  'To create your first project press on the plus button',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ]),
    ];

    return FloatingActionButton(
      key: _key1,
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
            gradient:
                LinearGradient(colors: [Color(0xff243C51), Color(0xff243C51)])),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
