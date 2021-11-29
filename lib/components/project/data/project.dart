import 'package:cloud_firestore/cloud_firestore.dart';

class Project {
  Timestamp? deadline;
  String? description;
  String? name;
  String? priority;
  String? uuid;
  Project(this.deadline, this.description, this.name, this.priority, this.uuid);

  factory Project.fromJson(Map<String, dynamic>? json) {
    return Project(json?["deadline"], json?["description"], json?["name"],
        json?["priority"], json?["uuid"]);
  }
}
