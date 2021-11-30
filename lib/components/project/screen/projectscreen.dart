import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procastiless/components/login/bloc/login_block.dart';
import 'package:procastiless/components/login/bloc/login_state.dart';
import 'package:procastiless/components/project/bloc/project_bloc.dart';
import 'package:procastiless/components/project/bloc/project_event.dart';
import 'package:procastiless/components/project/bloc/project_state.dart';

class ProjectScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProjectScreenState();
}

class ProjectScreenState extends State<ProjectScreen> {
  convertExpToLevel(int? exp) {
    if (exp == null) {
      return;
    }
    if (exp == 0) {
      return 1;
    }
    var form = (sqrt(67) * sqrt(8975 * exp - 1674)) / 335;
    return form.floor();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // changeToCollectedData(context);
    // TODO: implement build
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state is LoggedIn) {
          context.read<ProjectBloc>().add(new FetchProjectEvent());
          return SafeArea(
            child: Scaffold(
              body: Container(
                color: Colors.white,
                margin: EdgeInsets.only(top: 7),
                padding: const EdgeInsets.all(2),
                width: double.infinity,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome Back',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.apply(
                                        fontSizeFactor: 1.65,
                                        fontWeightDelta: 30,
                                        fontSizeDelta: 10),
                              ),
                              Text(
                                '${state.accountUser?.name}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.apply(fontSizeFactor: 2.3),
                              )
                            ],
                          ),
                          Image.asset('assets/images/bell.png'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Stack(
                      children: [
                        Image.network(
                          '${state.accountUser?.avatarUrl}',
                          height: 260,
                        ),
                        Positioned(
                          right: -.5,
                          child: Text('Level ' +
                              '${convertExpToLevel(state.accountUser?.exp)}'),
                        )
                      ],
                    ),
                    Flexible(
                      child: BlocBuilder<ProjectBloc, ProjectBaseState>(
                          builder: (context, state) {
                        if (state is ProjectLoadedState) {
                          if (state.projects.length == 0) {
                            return Text("No Projects created");
                          }
                          return ListView.builder(
                              itemCount: state.projects.length,
                              itemBuilder: (context, i) {
                                return ListTile(
                                  leading: Text("${state.projects[i]?.name}"),
                                );
                              });
                        } else if (state is ProjectLoadingState) {
                          return CircularProgressIndicator();
                        } else {
                          return Text("No Projects Found");
                        }
                      }),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return Scaffold(
          body: Container(),
        );
      },
    );
  }
}
