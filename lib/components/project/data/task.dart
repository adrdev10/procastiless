import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Task extends Equatable {
  String? color;
  bool? isCompleted;
  String? name;
  String? overview;
  String? taskBelongsTo;
  Task(
      {this.color,
      this.isCompleted,
      this.name,
      this.overview,
      this.taskBelongsTo})
      : super();

  factory Task.fromJson(Map<String, dynamic>? json) {
    return Task(
        color: json?["color"],
        isCompleted: json?["isCompleted"],
        name: json?["name"],
        overview: json?["overview"],
        taskBelongsTo: json?["taskBelongsTo"]);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': this.name,
      'overview': this.overview,
      'color': this.color,
      'isCompleted': this.isCompleted,
      'taskBelongsTo': this.taskBelongsTo,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
