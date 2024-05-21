import 'package:flutter_application_1/data/models/task.dart';
import 'package:flutter_application_1/domain/entities/task.dart';

class TaskMapper {
  Future<TaskModel> mapTaskEntity(TaskEntity task) async {
    return TaskModel(
      id: task.id,
      name: task.name,
      createdAt: task.createdAt,
      description: task.description,
      isCompleted: task.isCompleted,
      isFavourite: task.isFavourite,
      categoryId: task.categoryId,
    );
  }

  Future<TaskEntity> mapTaskModel(TaskModel task) async {
    return TaskEntity(
      id: task.id,
      name: task.name,
      createdAt: task.createdAt,
      description: task.description,
      isCompleted: task.isCompleted,
      isFavourite: task.isFavourite,
      categoryId: task.categoryId,
    );
  }
}