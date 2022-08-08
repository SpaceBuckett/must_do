class Task {
  int? id;
  String? task;
  bool? isDone;

  Task({
    this.id,
    this.task,
    this.isDone,
  });

  Task.fromJson(json, id) {
    this.id = json['id'];
    this.task = json['tast'];
    this.isDone = json['isDone'] ?? false;
  }
}
