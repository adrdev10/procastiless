import 'package:procastiless/components/project/data/project.dart';
import 'package:procastiless/components/project/data/task.dart';

abstract class ProjectBaseState {}

class ProjectLoadingState extends ProjectBaseState {}

class ProjectLoadedState extends ProjectBaseState {
  List<Project?> projects;
  List<Task?> tasks;
  ProjectLoadedState(this.projects, this.tasks);
}

class ProjectZeroState extends ProjectBaseState {}
