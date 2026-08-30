/// نموذج يمثل اقتراح مهمة واحدة مرتبطة بمهنة معينة (قادم من ملف البيانات)
class TaskSuggestion {
  final String title;
  final String category;
  final String time;

  TaskSuggestion({
    required this.title,
    required this.category,
    required this.time,
  });

  factory TaskSuggestion.fromJson(Map<String, dynamic> json) {
    return TaskSuggestion(
      title: json['title'] ?? '',
      category: json['category'] ?? 'يومي',
      time: json['time'] ?? '08:00 ص',
    );
  }
}

/// نموذج يمثل مهنة واحدة مع وصفها ومهامها المقترحة
class Profession {
  final String id;
  final String nameAr;
  final String nameEn;
  final String descriptionAr;
  final List<TaskSuggestion> suggestedTasks;

  Profession({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.descriptionAr,
    required this.suggestedTasks,
  });

  factory Profession.fromJson(Map<String, dynamic> json) {
    final tasksJson = (json['suggested_tasks'] as List<dynamic>? ?? []);
    return Profession(
      id: json['id'] ?? '',
      nameAr: json['name_ar'] ?? '',
      nameEn: json['name_en'] ?? '',
      descriptionAr: json['description_ar'] ?? '',
      suggestedTasks:
          tasksJson.map((t) => TaskSuggestion.fromJson(t)).toList(),
    );
  }
}
