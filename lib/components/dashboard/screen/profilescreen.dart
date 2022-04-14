import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procastiless/components/login/bloc/login_event.dart';
import 'package:procastiless/components/login/bloc/login_state.dart';
import 'package:procastiless/components/project/bloc/project_bloc.dart';
import 'package:procastiless/components/project/bloc/project_state.dart';
import 'package:procastiless/components/project/bloc/task_bloc.dart';
import 'package:procastiless/components/project/bloc/task_state.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../login/bloc/login_block.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var tempWdiget = Container(
      child: OutlinedButton(
        child: Text(
          'Sign out',
          style: TextStyle(color: Colors.black26),
        ),
        onPressed: () {
          context.read<LoginBloc>().add(new LogOutEvent());
          Navigator.popUntil(context, ModalRoute.withName('/login'));
        },
      ),
    );
    // TODO: implement build
    return BlocBuilder<LoginBloc, LoginState>(builder: ((context, state) {
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
              top: MediaQuery.of(context).size.height * .30,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(color: Colors.white24),
                child: BlocBuilder<ProjectBloc, ProjectBaseState>(
                  builder: (context, prstate) {
                    return BlocBuilder<TaskBloc, TaskBaseState>(
                      builder: (context, taskstate) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Positioned(
                              top: MediaQuery.of(context).size.height * .35,
                              child: Text(
                                  '${state.auth.currentUser?.displayName}'),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Icon(Icons.palette_outlined),
                                    Text("Projects"),
                                    Text(
                                        '${(prstate as ProjectLoadedState).projects.length}'),
                                  ],
                                ),
                                SizedBox(width: 50),
                                Column(
                                  children: [
                                    Icon(Icons.filter_drama_outlined),
                                    Text("Completed"),
                                    Text(
                                        '${(prstate as ProjectLoadedState).projects.map((e) => e?.progress == 100).toList().length}'),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
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
              child: tempWdiget,
              bottom: 20,
            ),
          ],
        ),
      );
    }));
  }
}
