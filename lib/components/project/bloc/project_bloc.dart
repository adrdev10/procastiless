import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procastiless/components/login/bloc/login_state.dart';
import 'package:procastiless/components/project/bloc/project_event.dart';
import 'package:procastiless/components/project/bloc/project_state.dart';
import 'package:procastiless/components/project/data/project.dart';

class ProjectBloc extends Bloc<ProjectEvents, ProjectBaseState> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  LoginState _loginBloc;
  ProjectBloc(ProjectBaseState initialState, LoginState loginBloc)
      : _loginBloc = loginBloc,
        super(initialState);

  LoginState get loginBloc => _loginBloc;

  @override
  Stream<ProjectBaseState> mapEventToState(ProjectEvents event) async* {
    List<ProjectBaseState> states = [];

    switch (event.runtimeType) {
      case FetchProjectEvent:
        _fetchProjects(states);
        break;
      case ReloadProjectEvent:
        break;
    }

    for (ProjectBaseState state in states) {
      yield state;
    }
  }

  void _fetchProjects(List<ProjectBaseState> states) async {
    try {
      emit(ProjectLoadingState());
      var userProjects = await fetchProjectsFromFirestore();
      if (userProjects.length < 1) {
        emit(ProjectZeroState());
        return;
      }
      emit(ProjectLoadedState(userProjects));
    } catch (e) {
      print(e);
    }
  }

  Future<List<Project>> fetchProjectsFromFirestore() async {
    List<Project> projects = [];
    final dbprojects = await firestore
        .collection('project')
        .where('uuid', isEqualTo: (loginBloc as LoggedIn).accountUser?.uuid)
        .get();
    if (dbprojects.size >= 1) {
      dbprojects.docs.forEach((element) {
        projects.add(new Project.fromJson(element.data()));
      });
      return projects;
    }
    return [];
  }
}
