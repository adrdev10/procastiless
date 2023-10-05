import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procastiless/components/login/bloc/login_state.dart';
import 'package:procastiless/components/project/bloc/project_event.dart';
import 'package:procastiless/components/project/bloc/project_state.dart';
import 'package:procastiless/components/project/bloc/task_bloc.dart';
import 'package:procastiless/components/project/bloc/task_state.dart';
import 'package:procastiless/components/project/data/project.dart';
import 'package:procastiless/components/project/data/task.dart';
import 'package:uuid/uuid.dart';

class ProjectBloc extends Bloc<ProjectEvents, ProjectBaseState> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  LoginState _loginBloc;
  TaskBloc _taskBloc;
  late StreamSubscription _streamSubscription;

  ProjectBloc(
      ProjectBaseState initialState, LoginState loginBloc, this._taskBloc)
      : _loginBloc = loginBloc,
        super(initialState) {
    _taskBlocSubscription();
  }

  LoginState get loginBloc => _loginBloc;

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }

  void _taskBlocSubscription() {
    _streamSubscription = _taskBloc.stream.listen((state) {
      if (state is TaskLoadedState) {
        var taskPerProjects = <String, List<Task>>{};
        for (var task in state.tasks) {
          if (task.taskBelongsTo != null) {
            taskPerProjects.putIfAbsent(task.taskBelongsTo!, () => []);
            taskPerProjects[task.taskBelongsTo]!.add(task);
          }
        }
        for (var entry in taskPerProjects.entries) {
          var completedTasks = (entry.value
                      .where((element) => element.isCompleted == true)
                      .length /
                  entry.value.length) *
              100.toDouble();
          add(UpdateProjectCompletedTaskCount(completedTasks, entry.key));
        }
      }
    });
  }

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
      case UpdateProjectCompletedTaskCount:
        if (state is ProjectLoadedState) {
          final updatedCount =
              (event as UpdateProjectCompletedTaskCount).completedTaskCount;
          final projectIdToUpdate = event.projectId;
          List<Project?> updatedProjects =
              (state as ProjectLoadedState).projects.map((project) {
            if (project?.id == projectIdToUpdate) {
              project?.progress = updatedCount.toInt();
              return project;
            }
            return project;
          }).toList();
          if (!listEquals(
              (state as ProjectLoadedState).projects, updatedProjects)) {
            states.add(ProjectLoadedState(updatedProjects));
          }
        }
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
      // ignore: invalid_use_of_visible_for_testing_member
      emit(ProjectLoadingState());
      var userProjects = await fetchProjectsFromFirestore();
      if (userProjects.length < 1) {
        // ignore: invalid_use_of_visible_for_testing_member
        emit(ProjectZeroState());
        return;
      }
      // ignore: invalid_use_of_visible_for_testing_member
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
    var uuid = Uuid();
    project?.uuid = (loginBloc as LoggedIn).accountUser?.uuid;
    project?.id = uuid.v4();
    var projectAdded =
        await firestore.collection('project').add(project!.toJson());
    // ignore: unnecessary_null_comparison
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

  @override
  void onTransition(Transition<ProjectEvents, ProjectBaseState> transition) {
    // TODO: implement onTransition
    super.onTransition(transition);
    print(transition);
  }

  @override
  void onChange(Change<ProjectBaseState> change) {
    // TODO: implement onChange
    super.onChange(change);
    print(change);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    // TODO: implement onError
    super.onError(error, stackTrace);
    print(error);
  }
}
