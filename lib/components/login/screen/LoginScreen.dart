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
    // TODO: implement initState
    super.initState();
    auth = FirebaseAuth.instance;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(WaitingToLogin()),
      child: Scaffold(
        body: Container(child:
            BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
          return Row(
            children: [
              if (state is WaitingToLogin) ...[
                FloatingActionButton(
                  heroTag: "signin",
                  onPressed: () {
                    context.read<LoginBloc>().add(new SignInEvent());
                  },
                  child: Text("Sigin in"),
                ),
                FloatingActionButton(
                  heroTag: "logout",
                  onPressed: () {
                    context.read<LoginBloc>().add(new LogOutEvent());
                  },
                  child: Text("Sign out"),
                ),
              ],
              if (state is LoggedIn) ...[
                Text("Logged in"),
                FloatingActionButton(
                  heroTag: "logout",
                  onPressed: () {
                    context.read<LoginBloc>().add(new LogOutEvent());
                  },
                  child: Text("Sign out"),
                ),
              ],
            ],
          );
        })),
      ),
    );
  }
}
