import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Task {
  String? color;
  bool? isCompleted;
  String? name;
  String? overview;
  String? taskBelongsTo;
  Task(this.color, this.isCompleted, this.name, this.overview,
      this.taskBelongsTo);

  factory Task.fromJson(Map<String, dynamic>? json) {
    return Task(json?["color"], json?["isCompleted"], json?["name"],
        json?["overview"], json?["taskBelongsTo"]);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': this.name,
      'overview': this.overview,
      'color': this.color,
      'isCompleted': this.isCompleted,
      'belongsTo': this.taskBelongsTo,
    };
  }
}
