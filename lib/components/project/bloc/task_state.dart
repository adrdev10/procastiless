import 'package:equatable/equatable.dart';
import 'package:procastiless/components/project/data/task.dart';

abstract class TaskBaseState extends Equatable {}

class TaskLoadingState extends TaskBaseState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class TaskLoadedState extends TaskBaseState {
  List<Task>? tasks;
  TaskLoadedState(this.tasks);

  @override
  // TODO: implement props
  List<Object?> get props => [tasks];
}

class TaskZeroState extends TaskBaseState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
