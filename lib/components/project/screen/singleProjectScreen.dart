import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:procastiless/components/project/bloc/task_bloc.dart';
import 'package:procastiless/components/project/bloc/task_event.dart';
import 'package:procastiless/components/project/bloc/task_state.dart';
import 'package:procastiless/components/project/data/project.dart';
import 'package:procastiless/components/project/data/task.dart';
import 'package:checkmark/checkmark.dart';

class SingleProjectScreen extends StatefulWidget {
  Project? project;
  SingleProjectScreen(this.project);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SingleProjectScreenState();
  }
}

class SingleProjectScreenState extends State<SingleProjectScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title.text = widget.project!.name!;
    description.text = widget.project!.description!;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print(title.text);
  }

  void doNothing(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    context.read<TaskBloc>().add(new FetchTaskEvent(widget.project?.name));
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            size: 28,
            color: Color(0xff243C51),
          ),
        ),
      ),
      body: BlocBuilder<TaskBloc, TaskBaseState>(builder: (context, state) {
        if (state is TaskLoadedState || state is TaskZeroState)
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(15.0),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  style: TextStyle(fontSize: 25, color: Color(0xff243C51)),
                  controller: title,
                  decoration: InputDecoration.collapsed(
                    hintText: "",
                    border: InputBorder.none,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text("Progress "),
                    if (state is TaskLoadedState)
                      Text(
                          "${((state.tasks!.where((element) => element.isCompleted!).length / (state).tasks!.length) * 100).toInt()}%")
                    else
                      Text("${0}%")
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width / 120,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  width: MediaQuery.of(context).size.width * .9,
                  height: 14.5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    child: LinearProgressIndicator(
                      color: Color(0xff243C51),
                      backgroundColor: Color(0xff5686b0),
                      value: (state is TaskLoadedState)
                          ? (state.tasks!
                                      .where((element) => element.isCompleted!)
                                      .length /
                                  (state).tasks!.length) *
                              100
                          : 0,
                      minHeight: 13,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  style: TextStyle(fontSize: 13, color: Color(0xffa5a9ad)),
                  controller: description,
                  decoration: InputDecoration.collapsed(
                    hintText: "",
                    border: InputBorder.none,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.calendar_today_rounded),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Deadline",
                              style: TextStyle(
                                  fontSize: 14, color: Color(0xffa5a9ad)),
                            ),
                            Text(
                              DateFormat.yMMMd()
                                  .format(widget.project!.deadline!.toDate()),
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.task_alt_outlined),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Status",
                              style: TextStyle(
                                  fontSize: 14, color: Color(0xffa5a9ad)),
                            ),
                            if (state is TaskLoadedState &&
                                state.tasks
                                        ?.where(
                                            (element) => element.isCompleted!)
                                        .length ==
                                    state.tasks!.length)
                              Text("Finished")
                            else if (state is TaskLoadedState)
                              Text("In Progress")
                            else if (state is TaskZeroState)
                              Text("Not Started")
                            else
                              Text("Error")
                          ],
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Tasks ",
                  style: TextStyle(fontSize: 15, color: Color(0xff243C51)),
                ),
                BlocBuilder<TaskBloc, TaskBaseState>(builder: (context, state) {
                  if (state is TaskLoadedState) {
                    return Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ListView.builder(
                            itemCount: state.tasks?.length,
                            itemBuilder: (context, i) {
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Slidable(
                                    key: Key(i.toString()),
                                    startActionPane: ActionPane(
                                      // A motion is a widget used to control how the pane animates.
                                      motion: const ScrollMotion(),

                                      // A pane can dismiss the Slidable.
                                      dismissible:
                                          DismissiblePane(onDismissed: () {}),

                                      // All actions are defined in the children parameter.
                                      children: [
                                        // A SlidableAction can have an icon and/or a label.
                                        SlidableAction(
                                          onPressed: (BuildContext context) {
                                            context.read<TaskBloc>().add(
                                                new DeleteTaskEvent(
                                                    state.tasks![i].name!));
                                          },
                                          backgroundColor: Color(0xFFFE4A49),
                                          foregroundColor: Colors.white,
                                          icon: Icons.delete,
                                          label: 'Delete',
                                        ),
                                      ],
                                    ),
                                    // The end action pane is the one at the right or the bottom side.
                                    endActionPane: ActionPane(
                                      motion: ScrollMotion(),
                                      children: [
                                        SlidableAction(
                                          // An action can be bigger than the others.
                                          flex: 2,
                                          onPressed: doNothing,
                                          backgroundColor: Color(0xFF7BC043),
                                          foregroundColor: Colors.white,
                                          icon: Icons.archive,
                                          label: 'Archive',
                                        ),
                                        SlidableAction(
                                          onPressed: doNothing,
                                          backgroundColor: Color(0xFF0392CF),
                                          foregroundColor: Colors.white,
                                          icon: Icons.save,
                                          label: 'Save',
                                        ),
                                      ],
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Color(0xfff7f7f7),
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: CheckMark(
                                                active: (state
                                                    .tasks![i].isCompleted!),
                                                duration: const Duration(
                                                    milliseconds: 500),
                                                curve: Curves.decelerate,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            height: 40,
                                            alignment: Alignment.center,
                                            child: Text(
                                              "${state.tasks?[i].name}",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              );
                            }),
                      ),
                    );
                  }
                  if (state is TaskLoadingState) {
                    return LinearProgressIndicator();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Center(child: Text("No tasks found")),
                  );
                })
              ],
            ),
          );
        return Container();
      }),
    );
  }
}
