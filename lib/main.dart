import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procastiless/components/dashboard/screen/dashboardscreen.dart';
import 'package:procastiless/components/login/bloc/login_block.dart';
import 'package:procastiless/components/login/bloc/login_event.dart';
import 'package:procastiless/components/login/bloc/login_state.dart';
import 'package:procastiless/components/login/screen/LoginScreen.dart';
import 'package:procastiless/components/paywall/bloc/PaywallBloc.dart';
import 'package:procastiless/components/paywall/bloc/PaywallState.dart';
import 'package:procastiless/components/paywall/screens/PaywallScreen.dart';
import 'package:procastiless/components/project/bloc/project_bloc.dart';
import 'package:procastiless/components/project/bloc/task_bloc.dart';
import 'package:procastiless/components/project/bloc/task_state.dart';
import 'package:procastiless/widgets/splash-widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'components/project/bloc/project_state.dart';
import 'config/themes/maintheme.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  var loginProvider = LoginBloc(WaitingToLogin());
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<LoginBloc>(create: (context) => loginProvider),
      BlocProvider<PaywallBloc>(
        create: (context) =>
            PaywallBloc(firestore, loginProvider, PaywallIdleState()),
      ),
      BlocProvider<TaskBloc>(
          create: (context) => TaskBloc(TaskZeroState(), loginProvider.state)),
      BlocProvider<ProjectBloc>(
        create: (context) => ProjectBloc(
          ProjectLoadingState(),
          BlocProvider.of<LoginBloc>(context).state,
          BlocProvider.of<TaskBloc>(context), // Pass TaskBloc here
        ),
      ),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => LoginScreen(),
        '/paywall': (context) => PaywallScreen(),
      },
      theme: MainTheme().getTheme(),
      title: 'Procastiless',
      home: StreamBuilder<User?>(
        stream: _firebaseAuth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data != null) {
              context
                  .read<LoginBloc>()
                  .add(new CheckIfAccountExist(snapshot.data?.uid ?? ""));
              return Dashboard(); // Navigates if user is logged in.
            } else {
              return LoginScreen(); // Navigates if user is not logged in.
            }
          }
          return SplashScreen(); // Returns a splash screen while waiting for connection.
        },
      ),
    ),
  ));
}

class Procastiless extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new ProcastelessState();
}

class ProcastelessState extends State<Procastiless> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text("Hello World"),
      ),
    );
  }
}
