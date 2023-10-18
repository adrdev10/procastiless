import 'package:cloud_firestore/cloud_firestore.dart';

class Project {
  Timestamp? deadline;
  String? description;
  String? name;
  int progress;
  String? priority;
  String? uuid;
  String? id;
  Project(this.deadline, this.description, this.name, this.priority, this.uuid,
      this.progress, this.id);

  factory Project.fromJson(Map<String, dynamic>? json) {
    return Project(json?["deadline"], json?["description"], json?["name"],
        json?["priority"], json?["uuid"], json?['progress'], json?["id"]);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': this.name,
      'description': this.description,
      'deadline': this.deadline,
      'priority': this.priority,
      'progress': this.progress,
      'uuid': this.uuid,
      'id': this.id,
    };
  }
}
