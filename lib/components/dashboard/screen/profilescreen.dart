import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procastiless/components/login/bloc/login_event.dart';
import 'package:procastiless/components/login/bloc/login_state.dart';
import 'package:procastiless/components/login/screen/LoginScreen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../login/bloc/login_block.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: ((context, state) {
      if (state is WaitingToLogin) {
        return Container();
      }
      return Scaffold(
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height * .1,
              child: Column(
                children: [
                  Text(
                    "Profile",
                    style: TextStyle(fontSize: 19),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: Image.network(
                        '${(state as LoggedIn).auth.currentUser?.photoURL}'),
                  ),
                ],
              ),
            ),
            Positioned(
                child: GestureDetector(
                  child: Text("Buy me a coffee ❤️"),
                  onTap: () async {
                    await launch("https://www.buymeacoffee.com/adriandeast");
                  },
                ),
                bottom: 70),
            Positioned(
              child: Container(
                child: OutlinedButton(
                  child: Text(
                    'Sign out',
                    style: TextStyle(color: Colors.black26),
                  ),
                  onPressed: () {
                    context.read<LoginBloc>().add(new LogOutEvent());
                    WidgetsBinding.instance?.addPostFrameCallback((_) {
                      Navigator.popUntil(
                          context, ModalRoute.withName('/login'));
                    });
                  },
                ),
              ),
              bottom: 20,
            ),
          ],
        ),
      );
    }));
  }
}
