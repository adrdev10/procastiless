import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procastiless/components/login/bloc/login_state.dart';
import 'package:procastiless/components/project/bloc/task_event.dart';
import 'package:procastiless/components/project/bloc/task_state.dart';
import 'package:procastiless/components/project/data/task.dart';

class TaskBloc extends Bloc<TaskEvents, TaskBaseState> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  LoginState _loginBloc;
  TaskBloc(TaskBaseState initialState, LoginState loginBloc)
      : _loginBloc = loginBloc,
        super(initialState);

  LoginState get loginBloc => _loginBloc;

  @override
  Stream<TaskBaseState> mapEventToState(TaskEvents event) async* {
    List<TaskBaseState> states = [];

    switch (event.runtimeType) {
      case FetchTaskEvent:
        yield TaskLoadingState();
        states.add(await _fetchTasks(states, event));
        break;
      case CreateTaskEvent:
        yield TaskLoadingState();
        states.add(await _createTasksForProject(
            states, event, (event as CreateTaskEvent).task));
        break;
      case DeleteTaskEvent:
        yield TaskLoadingState();
        states.add(await _deleteTask(
            states, event, (event as DeleteTaskEvent).taskName));
        break;
      case UpdateTaskEvent:
        yield TaskLoadingState();
        states.add(await _updateTasks(
            states, event, (event as UpdateTaskEvent).taskName, event.task));
        break;
      case FetchAllTasks:
        yield TaskLoadingState();
        states.add(await _fetchAllTasks(
            states, event, (event as FetchAllTasks).projectIds));
        break;
      case ReloadTaskEvent:
        break;
      default:
        break;
    }

    for (TaskBaseState state in states) {
      yield state;
    }
  }

  Future<TaskBaseState> _updateTasks(List<TaskBaseState> states,
      TaskEvents event, String taskName, Task? task) async {
    var projectForUpdate =
        firestore.collection('task').where('name', isEqualTo: taskName);
    var arraySnap = await projectForUpdate.get();
    for (var project in arraySnap.docs) {
      await project.reference.update(task!.toJson());
    }
    return _fetchTasks(
        states, FetchTaskEvent((event as UpdateTaskEvent).currentProject));
  }

  Future<TaskBaseState> _fetchTasks(
      List<TaskBaseState> states, TaskEvents event) async {
    try {
      var tasks = await fetchTasksFromFirestore((event as FetchTaskEvent).id);
      if (tasks.length < 1) {
        return TaskZeroState();
      }
      // Create a new instance of TaskLoadedState with updated tasks.
      var loadedTasks = TaskLoadedState(tasks: tasks);
      return loadedTasks;
    } catch (e) {
      print(e);
      return TaskZeroState();
    }
  }

  Future<List<Task>> fetchTasksFromFirestore(String? id) async {
    List<Task> tasks = [];
    final dbTasks = await firestore
        .collection('task')
        .where('taskBelongsTo', isEqualTo: id)
        .get();
    if (dbTasks.size >= 1) {
      dbTasks.docs.forEach((element) {
        tasks.add(new Task.fromJson(element.data()));
      });
      return tasks;
    }
    return [];
  }

  Future<TaskBaseState> _createTasksForProject(
      List<TaskBaseState> states, TaskEvents event, Task? task) async {
    await firestore.collection('task').add(task!.toJson());
    return _fetchTasks(
        states, FetchTaskEvent((event as CreateTaskEvent).currentProject));
  }

  Future<TaskBaseState> _deleteTask(
      List<TaskBaseState> states, TaskEvents event, String taskName) async {
    var projectForDeletion =
        firestore.collection('task').where('name', isEqualTo: taskName);
    var arraySnap = await projectForDeletion.get();
    for (var project in arraySnap.docs) {
      await project.reference.delete();
    }
    return _fetchTasks(
        states, FetchTaskEvent((event as DeleteTaskEvent).projectUUID));
  }

  Future<TaskBaseState> _fetchAllTasks(List<TaskBaseState> states,
      TaskEvents event, List<String?> projectIds) async {
    List<Task> allTasks = [];
    for (var projectId in projectIds) {
      // Fetch tasks related to the current projectId
      var projectTasksQuery = FirebaseFirestore.instance
          .collection('task')
          .where('taskBelongsTo', isEqualTo: projectId);

      var projectTasksSnapshot = await projectTasksQuery.get();
      var projectTasks = projectTasksSnapshot.docs
          .map((doc) => Task.fromJson(doc.data()))
          .toList();

      // Add the tasks to the cumulative list
      allTasks.addAll(projectTasks);
    }

    return TaskLoadedState(tasks: allTasks);
  }
}
