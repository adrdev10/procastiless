import 'package:equatable/equatable.dart';
import 'package:procastiless/components/project/data/task.dart';

abstract class TaskEvents extends Equatable {}

class FetchTaskEvent extends TaskEvents {
  final String? id;
  FetchTaskEvent(this.id);

  @override
  List<Object?> get props => throw UnimplementedError();
}

class ReloadTaskEvent extends TaskEvents {
  @override
  List<Object?> get props => [];
}

class CreateTaskEvent extends TaskEvents {
  final Task? task;
  final String? currentProject;
  CreateTaskEvent(this.task, this.currentProject);

  @override
  List<Object?> get props => [task];
}

class DeleteTaskEvent extends TaskEvents {
  final String taskName;
  final String? projectUUID;
  DeleteTaskEvent(this.taskName, this.projectUUID);

  @override
  List<Object?> get props => [taskName, projectUUID];
}

class UpdateTaskEvent extends TaskEvents {
  final String taskName;
  final String? currentProject;
  final Task? task;
  UpdateTaskEvent(this.taskName, this.currentProject, this.task);
  @override
  List<Object?> get props => [taskName, currentProject, task];
}

// ignore: must_be_immutable
class FetchAllTasks extends TaskEvents {
  List<String?> projectIds;
  FetchAllTasks(this.projectIds);
  @override
  List<Object?> get props => [projectIds];
}
