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
        _createTasksForProject(states, (event as CreateTaskEvent).task);
        break;
      case DeleteTaskEvent:
        yield TaskLoadingState();
        states.add(await _deleteTask(
            states, event, (event as DeleteTaskEvent).taskName));
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

  Future<TaskBaseState> _fetchTasks(
      List<TaskBaseState> states, TaskEvents event) async {
    try {
      var tasks = await fetchTasksFromFirestore(
          (event as FetchTaskEvent).currentProject);
      if (tasks.length < 1) {
        return TaskZeroState();
      }
      return TaskLoadedState(tasks);
    } catch (e) {
      print(e);
      return TaskZeroState();
    }
  }

  Future<List<Task>> fetchTasksFromFirestore(String? projectName) async {
    List<Task> tasks = [];
    final dbTasks = await firestore
        .collection('task')
        .where('taskBelongsTo', isEqualTo: projectName)
        .get();
    if (dbTasks.size >= 1) {
      dbTasks.docs.forEach((element) {
        tasks.add(new Task.fromJson(element.data()));
      });
      return tasks;
    }
    return [];
  }

  Future<bool> _createTasksForProject(
      List<TaskBaseState> states, Task? task) async {
    var projectAdded = await firestore.collection('task').add(task!.toJson());
    return projectAdded != null;
  }

  Future<TaskBaseState> _deleteTask(
      List<TaskBaseState> states, TaskEvents event, String taskName) async {
    var projectForDeletion =
        firestore.collection('task').where('name', isEqualTo: taskName);
    var arraySnap = await projectForDeletion.get();
    for (var project in arraySnap.docs) {
      await project.reference.delete();
    }
    return _fetchTasks(states, event);
  }
}
