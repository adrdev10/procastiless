import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:procastiless/components/dashboard/screen/dashboardscreen.dart';
import 'package:procastiless/components/login/bloc/login_block.dart';
import 'package:procastiless/components/login/bloc/login_state.dart';
import 'package:procastiless/components/project/bloc/project_bloc.dart';
import 'package:procastiless/components/project/bloc/project_event.dart';
import 'package:procastiless/components/project/bloc/project_state.dart';
import 'package:procastiless/components/project/bloc/task_bloc.dart';
import 'package:procastiless/components/project/bloc/task_event.dart';
import 'package:procastiless/components/project/bloc/task_state.dart';
import 'package:procastiless/components/project/models/project.dart';
import 'package:procastiless/components/project/models/task.dart';
import 'package:procastiless/components/project/screen/singleProjectScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class ProjectScreen extends StatefulWidget {
  final TutorialSettigns showTutorial;
  ProjectScreen(this.showTutorial);
  @override
  State<StatefulWidget> createState() => ProjectScreenState();
}

class ProjectScreenState extends State<ProjectScreen> {
  late final List<TargetFocus> targets;

  final GlobalKey _key2 = GlobalKey();
  final GlobalKey _key3 = GlobalKey();
  bool tasksNotAlreadyAvailable = true;

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
    targets = [
      TargetFocus(identify: "Target 2", keyTarget: _key2, contents: [
        TargetContent(
          align: ContentAlign.top,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Your List Of Projects 🦄',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: Text(
                  'To delete a project just long press on the project until it is removed',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ]),
      TargetFocus(identify: "Target 3", keyTarget: _key3, contents: [
        TargetContent(
          align: ContentAlign.top,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Leveling 👻',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: Text(
                  'Doing more projects will increase your level',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ]),
    ];
  }

  void showTutorial() async {
    final prefs = await SharedPreferences.getInstance();
    final shouldShowTutorial = prefs.getBool("isNewAccount") ?? false;
    if (shouldShowTutorial) {
      TutorialCoachMark(
        targets: targets, // List<TargetFocus>
        colorShadow: Colors.black38, // DEFAULT Colors.black
        // alignSkip: Alignment.bottomRight,
        // textSkip: "SKIP",
        paddingFocus: 10,
        // focusAnimationDuration: Duration(milliseconds: 500),
        // pulseAnimationDuration: Duration(milliseconds: 500),
        // pulseVariation: Tween(begin: 1.0, end: 0.99),
        onFinish: () {
          print("Your List Of Projects");
        },
        onClickTarget: (target) {
          print(target);
        },
        onSkip: () {
          print("skip");
        },
      )..show(context: context);
    }
    prefs.setBool("isNewAccount", false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state is LoggedIn) {
          if (tasksNotAlreadyAvailable) {
            context.read<ProjectBloc>().add(
                  new FetchProjectEvent(""),
                );
            tasksNotAlreadyAvailable = false;
          }
          return SafeArea(
            child: Scaffold(
              body: Container(
                color: Colors.white12,
                margin: EdgeInsets.only(top: 2),
                width: double.infinity,
                height: double.infinity,
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
                                'Hello 👋',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.apply(
                                        fontSizeFactor: 1.65,
                                        fontWeightDelta: 30,
                                        fontSizeDelta: 10),
                              ),
                              Text(
                                '${state.accountUser?.name}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.apply(fontSizeFactor: 2.3),
                              )
                            ],
                          ),
                          Image.asset('assets/images/bell1.png'),
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
                          height: 210,
                        ),
                        Positioned(
                          right: -.5,
                          child: Text(
                            'Level ' +
                                '${convertExpToLevel(state.accountUser?.exp)}',
                            key: _key3,
                            style: TextStyle(color: Color(0xff243C51)),
                          ),
                        )
                      ],
                    ),
                    BlocBuilder<ProjectBloc, ProjectBaseState>(
                        builder: (context, state) {
                      if (state is ProjectLoadedState) {
                        if (state.projects.length == 0) {
                          return Text("No Projects created");
                        }
                        context.read<TaskBloc>().add(FetchAllTasks(
                            state.projects.map((e) => e?.id).toList()));

                        if (widget.showTutorial.showTutorial) {
                          Future.delayed(
                            Duration(seconds: 2),
                            () {
                              showTutorial();
                            },
                          );
                        }
                        return BlocBuilder<TaskBloc, TaskBaseState>(
                            builder: (taskcontext, taskstate) {
                          return Expanded(
                            child: ListView.builder(
                                key: _key2,
                                physics: BouncingScrollPhysics(),
                                itemCount: state.projects.length,
                                itemBuilder: (context, i) {
                                  List<Task> tasks = [];
                                  Project project = Project(
                                      state.projects[i]!.deadline,
                                      state.projects[i]!.description,
                                      state.projects[i]!.name,
                                      state.projects[i]!.priority,
                                      state.projects[i]!.uuid,
                                      state.projects[i]!.progress,
                                      state.projects[i]!.id);
                                  if (taskstate is TaskLoadedState) {
                                    tasks = taskstate.tasks
                                        .where((element) =>
                                            element.taskBelongsTo == project.id)
                                        .toList();
                                  }
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return SingleProjectScreen(
                                              project,
                                              tasks,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    onLongPress: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            backgroundColor: Color(0xff243C51),
                                            title: Text(
                                                "Do you want to delete this project?",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.apply(
                                                        fontSizeFactor: 1.65,
                                                        color: Colors.white,
                                                        fontWeightDelta: 1,
                                                        fontSizeDelta: .4)),
                                            actions: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  context
                                                      .read<ProjectBloc>()
                                                      .add(
                                                          new DeleteProjectEvent(
                                                              project));
                                                  Future.delayed(
                                                      Duration(
                                                          milliseconds: 500),
                                                      () {
                                                    context
                                                        .read<ProjectBloc>()
                                                        .add(
                                                          new FetchProjectEvent(
                                                              ""),
                                                        );
                                                  });
                                                  Future.delayed(
                                                    Duration(milliseconds: 500),
                                                    () {
                                                      Navigator.pop(context);
                                                    },
                                                  );
                                                },
                                                child: Text("Yes, delete"),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  Future.delayed(
                                                    Duration(milliseconds: 50),
                                                    () {
                                                      Navigator.pop(context);
                                                    },
                                                  );
                                                },
                                                child: Text("No"),
                                              )
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(20),
                                      margin: const EdgeInsets.all(5),
                                      height: 120,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Color(0xff243C51),
                                      ),
                                      width: MediaQuery.of(context).size.width *
                                          .9,
                                      child: Row(children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${state.projects[i]!.name!.length >= 30 ? state.projects[i]!.name!.substring(0, 29).trim() + '...' : state.projects[i]?.name?.trim()}",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    height: 25,
                                                    width: 75,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: getPriorityColor(
                                                          state.projects[i]
                                                              ?.priority),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        '${state.projects[i]!.priority}',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "${state.projects[i]!.description!.length >= 30 ? state.projects[i]!.description!.substring(0, 29).toUpperCase().trim() + '...' : state.projects[i]?.description!.toUpperCase().trim()}",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12),
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                "${DateFormat.yMMMMEEEEd().format(state.projects[i]!.deadline!.toDate())}",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${project.progress}%",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17),
                                            )
                                          ],
                                        )
                                      ]),
                                    ),
                                  );
                                }),
                          );
                        });
                      } else if (state is ProjectLoadingState) {
                        return CircularProgressIndicator();
                      } else {
                        return Center(
                          child: Text("No Projects Found"),
                        );
                      }
                    }),
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

  getPriorityColor(String? priority) {
    switch (priority) {
      case "HIGH":
        return Colors.red;
      case "MEDIUM":
        return Color(0xffE4C864);
      default:
        return Color(0xff64C6E4);
    }
  }
}
