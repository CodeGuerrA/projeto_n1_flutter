class Subtask {
  String id;
  String title;
  bool done;
  Subtask({required this.id, required this.title, this.done = false});
}

class Task {
  String id;
  String title;
  String description;
  DateTime? dateTime;
  int priority; // 1 low, 2 medium, 3 high
  String? categoryId;
  List<Subtask> subtasks;

  Task({
    required this.id,
    required this.title,
    this.description = '',
    this.dateTime,
    this.priority = 2,
    this.categoryId,
    List<Subtask>? subtasks,
  }) : subtasks = subtasks ?? [];
}
