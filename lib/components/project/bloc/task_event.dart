import 'package:equatable/equatable.dart';
import 'package:procastiless/components/project/data/task.dart';

abstract class TaskEvents extends Equatable {}

class FetchTaskEvent extends TaskEvents {
  String? projectUUID;
  FetchTaskEvent(this.projectUUID);

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
  String? currentProject;
  CreateTaskEvent(this.task, this.currentProject);

  @override
  // TODO: implement props
  List<Object?> get props => [task];
}

class DeleteTaskEvent extends TaskEvents {
  String taskName;
  String? currentProject;
  DeleteTaskEvent(this.taskName, this.currentProject);

  @override
  // TODO: implement props
  List<Object?> get props => [taskName, currentProject];
}

class UpdateTaskEvent extends TaskEvents {
  String taskName;
  String? currentProject;
  Task? task;
  UpdateTaskEvent(this.taskName, this.currentProject, this.task);
  @override
  // TODO: implement props
  List<Object?> get props => [taskName, currentProject, task];
}
