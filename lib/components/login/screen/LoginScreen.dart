import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procastiless/components/login/bloc/login_block.dart';
import 'package:procastiless/components/login/bloc/login_event.dart';
import 'package:procastiless/components/login/bloc/login_state.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  late FirebaseAuth auth;
  @override
  void initState() {
    super.initState();
    auth = FirebaseAuth.instance;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(WaitingToLogin()),
      child: Scaffold(
        body: SafeArea(
          child: Container(child:
              BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
            return Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .03,
                  ),
                  Text(
                    'Procastiless',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  RichText(
                      text: TextSpan(
                    text: 'A better FUN way to get things done',
                    style: Theme.of(context).textTheme.bodyText1,
                    children: const <TextSpan>[],
                  )),
                  Image.asset(
                    'images/Characther.png',
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                  if (state is WaitingToLogin) ...[
                    ElevatedButton(
                      onPressed: () {
                        context.read<LoginBloc>().add(new SignInEvent());
                      },
                      child: Text("Sigin in"),
                    ),
                  ],
                  if (state is LoggedIn) ...[
                    Text("Logged in"),
                    ElevatedButton(
                      onPressed: () {
                        context.read<LoginBloc>().add(new LogOutEvent());
                      },
                      child: Text("Sign out"),
                    ),
                  ],
                ],
              ),
            );
          })),
        ),
      ),
    );
  }
}
