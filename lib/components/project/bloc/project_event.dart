import 'package:procastiless/components/project/models/project.dart';

abstract class ProjectEvents {}

class FetchProjectEvent extends ProjectEvents {
  String? currentProject;
  FetchProjectEvent(this.currentProject);
}

class ReloadProjectEvent extends ProjectEvents {}

class CreateProjectEvent extends ProjectEvents {
  Project? project;
  CreateProjectEvent(this.project);
}

class DeleteProjectEvent extends ProjectEvents {
  Project? project;
  DeleteProjectEvent(this.project);
}

class UpdateProjetEvent extends ProjectEvents {}

class UpdateProjectCompletedTaskCount extends ProjectEvents {
  final String projectId;
  final double completedTaskCount;

  UpdateProjectCompletedTaskCount(this.completedTaskCount, this.projectId);
}
