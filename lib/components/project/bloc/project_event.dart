import 'package:procastiless/components/project/data/project.dart';

abstract class ProjectEvents {}

class FetchProjectEvent extends ProjectEvents {}

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
