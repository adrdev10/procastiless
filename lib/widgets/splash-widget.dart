import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:procastiless/components/login/screen/LoginScreen.dart';
import 'package:procastiless/main.dart';

final router = FluroRouter();

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  var usersHandler = Handler(
    handlerFunc: (context, parameters) {
      return LoginScreen();
    },
  );

  void defineRoutes(FluroRouter router) {
    router.define("/login", handler: usersHandler);
  }

  Future ticker() {
    return Future.delayed(Duration(seconds: 5));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    defineRoutes(router);
    ticker().then((value) => router.navigateTo(context, "/login",
        transition: TransitionType.inFromLeft));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Center(
        child: Text("Procastiless"),
      ),
    );
  }
}
