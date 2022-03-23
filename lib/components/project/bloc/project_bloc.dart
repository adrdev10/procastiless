import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procastiless/components/login/bloc/login_state.dart';
import 'package:procastiless/components/project/bloc/project_event.dart';
import 'package:procastiless/components/project/bloc/project_state.dart';
import 'package:procastiless/components/project/data/project.dart';
import 'package:procastiless/components/project/data/task.dart';

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
        _fetchProjects(states, event);
        break;
      case CreateProjectEvent:
        _createProject(states, (event as CreateProjectEvent).project);
        break;
      case DeleteProjectEvent:
        _deleteProject(states, (event as DeleteProjectEvent).project);
        break;
      case ReloadProjectEvent:
        break;
      default:
        break;
    }

    for (ProjectBaseState state in states) {
      yield state;
    }
  }

  void _fetchProjects(List<ProjectBaseState> states,
      [ProjectEvents? event]) async {
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
        .where('uuid', isEqualTo: (loginBloc as LoggedIn).auth.currentUser?.uid)
        .get();
    if (dbprojects.size >= 1) {
      dbprojects.docs.forEach((element) {
        projects.add(new Project.fromJson(element.data()));
      });
      return projects;
    }
    return [];
  }

  void _createProject(List<ProjectBaseState> states, Project? project) async {
    try {
      createProject(project);
    } catch (e) {
      print(e);
    }
  }

  Future<bool> createProject(Project? project) async {
    project?.uuid = (loginBloc as LoggedIn).accountUser?.uuid;
    var projectAdded =
        await firestore.collection('project').add(project!.toJson());
    return projectAdded != null;
  }

  void _deleteProject(List<ProjectBaseState> states, Project? project) async {
    try {
      deleteProject(project);
    } catch (e) {
      print(e);
    }
  }

  Future<bool> deleteProject(Project? project) async {
    project?.uuid = (loginBloc as LoggedIn).accountUser?.uuid;
    var projectForDeletion = firestore
        .collection('project')
        .where('uuid', isEqualTo: (loginBloc as LoggedIn).accountUser?.uuid)
        .where('name', isEqualTo: project?.name);
    var arraySnap = await projectForDeletion.get();
    for (var project in arraySnap.docs) {
      await project.reference.delete();
    }
    return true;
  }
}
