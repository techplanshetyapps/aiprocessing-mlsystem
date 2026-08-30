class Task {
  final String id;
  final String title;
  final String category;
  final String time;
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.category,
    required this.time,
    this.isCompleted = false,
  });
}