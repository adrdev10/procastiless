import 'package:procastiless/components/project/models/project.dart';

abstract class ProjectBaseState {}

class ProjectLoadingState extends ProjectBaseState {}

class ProjectLoadedState extends ProjectBaseState {
  List<Project?> projects;
  ProjectLoadedState(this.projects);
}

class ProjectZeroState extends ProjectBaseState {}
