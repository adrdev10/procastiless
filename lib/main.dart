import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:procastiless/constants/colors.dart';
import 'package:procastiless/widgets/splash-widget.dart';

import 'config/themes/defaultapptheme.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: colorNames['appbar-color'],
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      theme: ProcastilessTheme().mainDefaultTheme,
      title: 'Procastiless',
      home: Scaffold(
        body: SafeArea(
          child: SplashScreen(),
        ),
      ),
    ),
  );
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
