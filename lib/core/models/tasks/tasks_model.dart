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
    this.task = json['task'];
    this.isDone = json['isDone'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['task'] = this.task;
    data['isDone'] = this.isDone;
    return data;
  }
}
