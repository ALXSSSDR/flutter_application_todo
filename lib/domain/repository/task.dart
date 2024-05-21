import 'package:flutter_application_1/data/models/task.dart';

abstract class TaskRepository {
  Future<List<TaskModel>> getTasks(String categoryId);

  Future<TaskModel> getTask(String taskId);

  Future<void> addTask(TaskModel task);

  Future<void> editTask(String taskId, String name, String description);

  Future<void> removeTask(String taskId);

  Future<void> completeTask(String taskId, bool isCompleted);

  Future<void> favourTask(String taskId, bool isFavourite);
}