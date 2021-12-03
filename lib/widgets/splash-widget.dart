import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:procastiless/components/login/screen/LoginScreen.dart';

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
        transition: TransitionType.fadeIn,
        transitionDuration: Duration(milliseconds: 1000)));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Center(
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: TextLiquidFill(
                waveColor: Color(0xff3378B8),
                boxBackgroundColor: Colors.white,
                textStyle: TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold,
                ),
                boxHeight: MediaQuery.of(context).size.height * .5,
                text: 'Procrastiless',
                // child: AnimatedTextKit(animatedTexts: [
                //   WavyAnimatedText('Procrastiless'),
                // ]),
              ),
            )),
      ),
    );
  }
}
