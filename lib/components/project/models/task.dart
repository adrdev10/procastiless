import 'package:equatable/equatable.dart';

//ignore: must_be_immutable
class Task extends Equatable {
  final String? color;
  bool? isCompleted;
  final String? name;
  final String? overview;
  final String? taskBelongsTo;
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

  void setIsCompleted(bool isCompleted) => isCompleted = isCompleted;

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
  List<Object?> get props => [];
}
