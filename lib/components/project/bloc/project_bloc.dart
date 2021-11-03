import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procastiless/components/project/bloc/project_event.dart';
import 'package:procastiless/components/project/bloc/project_state.dart';

class ProjectBloc extends Bloc<ProjectEvents, ProjectBaseState> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  ProjectBloc(ProjectBaseState initialState) : super(initialState);
  @override
  Stream<ProjectBaseState> mapEventToState(ProjectEvents event) async* {
    List<ProjectBaseState> states = [];

    switch (event.runtimeType) {
      case FetchProjectEvent:
        break;
      case ReloadProjectEvent:
        break;
    }
  }
}
