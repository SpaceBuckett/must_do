class Task {
  String? id;
  String? userId;
  String? task;
  bool? isDone;

  Task({
    this.id,
    this.userId,
    this.task,
    this.isDone,
  });

  Task.fromJson(json, this.id) {
    // id = json['id'];
    userId = json['userId'];
    task = json['task'];
    isDone = json['isDone'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['task'] = task;
    data['isDone'] = isDone;
    return data;
  }
}
