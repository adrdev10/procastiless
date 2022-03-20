import 'package:equatable/equatable.dart';
import 'package:procastiless/components/project/data/task.dart';

abstract class TaskEvents extends Equatable {}

class FetchTaskEvent extends TaskEvents {
  String? currentProject;
  FetchTaskEvent(this.currentProject);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ReloadTaskEvent extends TaskEvents {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CreateTaskEvent extends TaskEvents {
  Task? task;
  CreateTaskEvent(this.task);

  @override
  // TODO: implement props
  List<Object?> get props => [task];
}

class DeleteTaskEvent extends TaskEvents {
  String taskName;
  DeleteTaskEvent(this.taskName);

  @override
  // TODO: implement props
  List<Object?> get props => [taskName];
}

class UpdateTaskEvent extends TaskEvents {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
