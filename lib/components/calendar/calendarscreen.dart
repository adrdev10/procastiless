import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procastiless/components/project/bloc/project_bloc.dart';
import 'package:procastiless/components/project/bloc/project_state.dart';

class CalendarScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CalendarScreenState();
  }
}

class CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return BlocBuilder<ProjectBloc, ProjectBaseState>(
      builder: (context, state) {
        List<DateTime>? date = [];
        if (state is ProjectLoadedState) {
          date.addAll(
              state.projects.map((e) => e!.deadline!.toDate()).toList());
        }
        date.sort((a, b) => a.compareTo(b));
        DateTime lastDate = date[date.length - 1];
        return Scaffold(
          appBar: CalendarAppBar(
            backButton: false,
            firstDate: DateTime.now().subtract(Duration(days: 365)),
            lastDate: lastDate,
            selectedDate: DateTime.now(),
            events: date,
            onDateChanged: (value) {
              print(value);
            },
          ),
        );
      },
    );
  }
}
