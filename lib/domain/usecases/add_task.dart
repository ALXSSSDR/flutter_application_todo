import 'package:flutter_application_1/data/mappers/task.dart';
import 'package:flutter_application_1/domain/entities/task.dart';
import 'package:flutter_application_1/domain/repository/task.dart';
import 'package:uuid/uuid.dart';

class AddTaskUseCase {
  final TaskRepository taskRepository;
  final TaskMapper taskMapper;

  AddTaskUseCase({
    required this.taskRepository,
    required this.taskMapper,
  });

  Future<void> execute(
      String name, String description, String categoryId) async {
    TaskEntity newTask = TaskEntity(
        id: const Uuid().v4(),
        name: name.trim(),
        createdAt: DateTime.now(),
        description: description,
        categoryId: categoryId);

    taskRepository.addTask(await taskMapper.mapTaskEntity(newTask));
  }
}
