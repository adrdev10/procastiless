import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Project {
  Timestamp? deadline;
  String? description;
  String? name;
  int progress;
  String? priority;
  String? uuid;
  Project(this.deadline, this.description, this.name, this.priority, this.uuid,
      this.progress);

  factory Project.fromJson(Map<String, dynamic>? json) {
    return Project(json?["deadline"], json?["description"], json?["name"],
        json?["priority"], json?["uuid"], json?['progress']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': this.name,
      'description': this.description,
      'deadline': this.deadline,
      'priority': this.priority,
      'progress': this.progress,
      'uuid': this.uuid
    };
  }
}
