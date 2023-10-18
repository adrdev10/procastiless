import 'package:equatable/equatable.dart';
import 'package:procastiless/components/project/models/task.dart';

abstract class TaskBaseState extends Equatable {}

class TaskLoadingState extends TaskBaseState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class TaskLoadedState extends TaskBaseState {
  final List<Task> tasks;
  TaskLoadedState({required this.tasks});

  TaskLoadedState addTasks(List<Task> newTasks) {
    return TaskLoadedState(tasks: [...tasks, ...newTasks]);
  }

  @override
  List<Object?> get props => [tasks];
}

class TaskZeroState extends TaskBaseState {
  @override
  List<Object?> get props => [];
}
