class Task {
  String id;
  String title;
  bool isCompleted;
  bool isFavourite;
  String categoryId;

  Task({required this.id, required this.title, required this.categoryId, this.isCompleted = false, this.isFavourite = false});
}