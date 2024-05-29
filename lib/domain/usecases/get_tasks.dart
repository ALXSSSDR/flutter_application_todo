import 'package:flutter_application_1/data/mappers/task.dart';
import 'package:flutter_application_1/domain/entities/task.dart';
import 'package:flutter_application_1/domain/repository/task.dart';
import 'package:flutter_application_1/domain/usecases/filter.dart';

class GetTasksUseCase {
  final FilterUseCase filterUseCase;
  final TaskRepository taskRepository;
  final TaskMapper taskMapper;

  GetTasksUseCase({
    required this.filterUseCase,
    required this.taskRepository,
    required this.taskMapper,
  });

  Future<List<TaskEntity>> getTasks(String categoryId) async {
    List<TaskEntity> tasks = await taskRepository.getTasks(categoryId);

    tasks = await filterUseCase.filterTasks(tasks, categoryId);

    tasks.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    tasks.sort((a, b) => b.isFavourite ? 1 : -1);

    return tasks;
  }
}
