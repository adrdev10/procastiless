import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:procastiless/widgets/splash-widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
      title: 'Procastiless',
      home: Scaffold(
        body: SafeArea(child: SplashScreen()),
      )));
}

class Procastiless extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new ProcastelessState();
}

class ProcastelessState extends State<Procastiless> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: Text("Hello World"),
      ),
    );
  }
}
