import 'package:procastiless/components/project/data/project.dart';
import 'package:procastiless/components/project/data/task.dart';

abstract class ProjectBaseState {}

class ProjectLoadingState extends ProjectBaseState {}

class ProjectLoadedState extends ProjectBaseState {
  List<Project?> projects;
  ProjectLoadedState(this.projects);
}

class ProjectZeroState extends ProjectBaseState {}
