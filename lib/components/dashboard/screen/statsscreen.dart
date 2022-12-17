import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procastiless/components/login/bloc/login_state.dart';
import 'package:procastiless/components/project/bloc/project_bloc.dart';
import 'package:procastiless/components/project/bloc/project_state.dart';
import 'package:procastiless/components/project/bloc/task_bloc.dart';
import 'package:procastiless/components/project/bloc/task_state.dart';

import '../../login/bloc/login_block.dart';

class StatsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StatsScreenState();
}

class StatsScreenState extends State<StatsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: ((context, state) {
      return Scaffold(
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              left: 10,
              top: MediaQuery.of(context).size.height * .1,
              child: Column(
                children: [
                  Text(
                    "See your project \ninsights",
                    style: TextStyle(fontSize: 29),
                  ),
                ],
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * .20,
              child: Container(
                width: MediaQuery.of(context).size.width * .8,
                height: MediaQuery.of(context).size.height * .5,
                decoration: BoxDecoration(color: Colors.white24),
                child: BlocBuilder<ProjectBloc, ProjectBaseState>(
                  builder: (context, prstate) {
                    return BlocBuilder<TaskBloc, TaskBaseState>(
                      builder: (context, taskstate) {
                        int daysTillNext = 0;
                        int dueOfToday = 0;
                        if (prstate is ProjectLoadedState ||
                            prstate
                                is ProjectZeroState) if (prstate
                            is ProjectLoadedState) {
                          var lastProject = prstate.projects
                              .map((element) => element!.deadline!
                                  .toDate()
                                  .difference(new DateTime.now())
                                  .inDays)
                              .toList();
                          if (lastProject.length > 0) {
                            daysTillNext = lastProject.last;
                          }
                          dueOfToday = prstate.projects
                              .where((e) =>
                                  e!.deadline!
                                      .toDate()
                                      .compareTo(DateTime.now()) ==
                                  0)
                              .length;
                        }
                        return GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          children: [
                            Column(
                              children: [
                                Icon(Icons.palette_outlined),
                                Text("Projects"),
                                if (prstate is ProjectZeroState)
                                  Text('0')
                                else
                                  Text(
                                      '${(prstate as ProjectLoadedState).projects.length}'),
                              ],
                            ),
                            Column(
                              children: [
                                Icon(Icons.filter_drama_outlined),
                                Text("Completed"),
                                if (prstate is ProjectZeroState)
                                  Text('0')
                                else
                                  Text(
                                      '${(prstate as ProjectLoadedState).projects.where((e) => e!.progress == 1).length}'),
                              ],
                            ),
                            Column(
                              children: [
                                Icon(Icons.timelapse),
                                Text("Days until\nnext project",
                                    textAlign: TextAlign.center),
                                if (prstate is ProjectZeroState)
                                  Text('$daysTillNext')
                                else
                                  Text('$daysTillNext'),
                              ],
                            ),
                            Column(
                              children: [
                                Icon(Icons.today_outlined),
                                Text("Due to day"),
                                if (prstate is ProjectZeroState)
                                  Text('$dueOfToday')
                                else
                                  Text('$dueOfToday'),
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
          ],
        ),
      );
    }));
  }
}
