import 'package:flutter_application_1/data/mappers/task.dart';
import 'package:flutter_application_1/domain/entities/task.dart';
import 'package:flutter_application_1/domain/repository/task.dart';
import 'package:flutter_application_1/domain/usecases/filter.dart';
import 'package:uuid/uuid.dart';

class TaskUseCase {
  final FilterUseCase filterUseCase;
  final TaskRepository taskRepository;
  final TaskMapper taskMapper;

  TaskUseCase(
      {required this.filterUseCase,
      required this.taskRepository,
      required this.taskMapper});

  Future<List<TaskEntity>> getTasks(String categoryId) async {
    List<TaskEntity> tasks = await Future.wait(
      (await taskRepository.getTasks(categoryId))
          .map((categoryModel) async =>
              await taskMapper.mapTaskModel(categoryModel))
          .toList(),
    );

    tasks = await filterUseCase.filterTasks(tasks, categoryId);

    tasks.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    tasks.sort((a, b) => b.isFavourite ? 1 : -1);

    return tasks;
  }

  Future<TaskEntity> getTask(String taskId) async {
    return taskMapper.mapTaskModel(await taskRepository.getTask(taskId));
  }

  Future<void> addTask(
      String name, String description, String categoryId) async {
    TaskEntity newTask = TaskEntity(
        id: const Uuid().v4(),
        name: name.trim(),
        createdAt: DateTime.now(),
        description: description,
        categoryId: categoryId);

    taskRepository.addTask(await taskMapper.mapTaskEntity(newTask));
  }

  Future<void> editTask(String taskId, String name, String description) async {
    taskRepository.editTask(taskId, name.trim(), description);
  }

  Future<void> removeTask(String taskId) async {
    taskRepository.removeTask(taskId);
  }

  Future<void> completeTask(String taskId, bool isCompleted) async {
    taskRepository.completeTask(taskId, isCompleted);
  }

  Future<void> favourTask(String taskId, bool isFavourite) async {
    taskRepository.favourTask(taskId, isFavourite);
  }
}