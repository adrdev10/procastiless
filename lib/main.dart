import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procastiless/components/login/bloc/login_block.dart';
import 'package:procastiless/components/login/bloc/login_state.dart';
import 'package:procastiless/components/login/screen/LoginScreen.dart';
import 'package:procastiless/widgets/splash-widget.dart';

import 'config/themes/maintheme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<LoginBloc>(create: (context) => LoginBloc(WaitingToLogin())),
    ],
    child: MaterialApp(
        routes: {'/login': (context) => LoginScreen()},
        theme: MainTheme().getTheme(),
        title: 'Procastiless',
        home: Scaffold(
          body: SafeArea(child: SplashScreen()),
        )),
  ));
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
