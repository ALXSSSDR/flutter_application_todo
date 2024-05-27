import 'package:flutter_application_1/data/datasources/local.dart';
import 'package:flutter_application_1/data/models/task.dart';
import 'package:flutter_application_1/domain/repository/filter.dart';
import 'package:flutter_application_1/domain/repository/task.dart';

class TaskRepositoryData implements TaskRepository {
  final LocalDataSource dataSource;
  final FilterRepository filterRepository;

  TaskRepositoryData({required this.dataSource, required this.filterRepository});

  @override
  Future<List<TaskModel>> getTasks(String categoryId) async {
    return dataSource.tasks.where((task) => task.categoryId == categoryId).toList();
  }

  @override
  Future<TaskModel> getTask(String taskId) async {
    return dataSource.tasks.where((task) => task.id == taskId).first;
  }

  @override
  Future<void> addTask(TaskModel task) async {
    dataSource.tasks.add(task);
  }

  @override
  Future<void> editTask(String taskId, String name, String description) async {
    TaskModel task = dataSource.tasks.firstWhere((task) => task.id == taskId);

    dataSource.tasks.remove(task);

    dataSource.tasks.add(TaskModel(
      id: task.id,
      name: name,
      description: description,
      createdAt: task.createdAt,
      isCompleted: task.isCompleted,
      isFavourite: task.isFavourite,
      categoryId: task.categoryId,
    ));
  }

  @override
  Future<void> removeTask(String taskId) async {
    dataSource.tasks.remove(dataSource.tasks.firstWhere((task) => task.id == taskId));
  }

  @override
  Future<void> completeTask(String taskId, bool isCompleted) async {
    TaskModel task = dataSource.tasks.firstWhere((task) => task.id == taskId);

    dataSource.tasks.remove(task);

    dataSource.tasks.add(TaskModel(
      id: task.id,
      name: task.name,
      description: task.description,
      createdAt: task.createdAt,
      isCompleted: isCompleted,
      isFavourite: task.isFavourite,
      categoryId: task.categoryId,
    ));
  }

  @override
  Future<void> favourTask(String taskId, bool isFavourite) async {
    TaskModel task = dataSource.tasks.firstWhere((task) => task.id == taskId);

    dataSource.tasks.remove(task);

    dataSource.tasks.add(TaskModel(
      id: task.id,
      name: task.name,
      description: task.description,
      createdAt: task.createdAt,
      isCompleted: task.isCompleted,
      isFavourite: isFavourite,
      categoryId: task.categoryId,
    ));
  }
}
