import 'package:procastiless/components/project/data/project.dart';

abstract class ProjectEvents {}

class FetchProjectEvent extends ProjectEvents {}

class ReloadProjectEvent extends ProjectEvents {}

class CreateProjectEvent extends ProjectEvents {
  Project? project;
  CreateProjectEvent(this.project);
}

class DeleteProjectEvent extends ProjectEvents {}

class UpdateProjetEvent extends ProjectEvents {}
