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
        late DateTime lastDate;
        if (state is ProjectLoadedState) {
          date.addAll(
              state.projects.map((e) => e!.deadline!.toDate()).toList());
        }
        if (date.length != 0) {
          date.sort((a, b) => a.compareTo(b));
          lastDate = date[date.length - 1];
        } else {
          lastDate = DateTime.now();
        }
        return Scaffold(
          appBar: CalendarAppBar(
            backButton: false,
            accent: Color(0xff3378B8),
            firstDate: DateTime.now().subtract(Duration(days: 365)),
            lastDate: lastDate != null ? lastDate : DateTime.now(),
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
