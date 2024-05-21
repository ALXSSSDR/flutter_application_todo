class TaskModel {
  final String id;
  final String name;
  final DateTime createdAt;
  final String description;
  bool isCompleted;
  bool isFavourite;
  final String categoryId;

  TaskModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.description,
    this.isCompleted = false,
    this.isFavourite = false,
    required this.categoryId,
  });
}
