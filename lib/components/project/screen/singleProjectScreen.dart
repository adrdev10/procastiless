import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:procastiless/components/project/data/project.dart';

class SingleProjectScreen extends StatefulWidget {
  Project? project;
  SingleProjectScreen(this.project);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SingleProjectScreenState();
  }
}

class SingleProjectScreenState extends State<SingleProjectScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.project!.name!),
      ),
    );
  }
}
