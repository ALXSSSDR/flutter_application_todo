import 'package:flutter_application_1/data/mappers/task.dart';
import 'package:flutter_application_1/domain/entities/image.dart';
import 'package:flutter_application_1/domain/entities/task.dart';
import 'package:flutter_application_1/domain/repository/task.dart';
import 'package:flutter_application_1/domain/usecases/filter.dart';
import 'package:flutter_application_1/domain/usecases/image.dart';

class GetTasksUseCase {
  final FilterUseCase filterUseCase;
  final TaskRepository taskRepository;
  final TaskMapper taskMapper;
  final ImgUseCase imgUseCase;

  GetTasksUseCase({
    required this.filterUseCase,
    required this.taskRepository,
    required this.taskMapper,
    required this.imgUseCase,
  });

  Future<List<TaskEntity>> getTasks(String categoryId) async {
    List<TaskEntity> tasks = await taskRepository.getTasks(categoryId);

    tasks = await filterUseCase.filterTasks(tasks, categoryId);

    tasks.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    tasks.sort((a, b) => b.isFavourite ? 1 : -1);

    List<TaskEntity> updatedTasks = [];
    for (TaskEntity task in tasks) {
      List<ImgEntity> imgUrls = await imgUseCase.getImgsOfTask(task.id);
      TaskEntity updatedTask = task.copyWith(imgUrls: imgUrls);
      updatedTasks.add(updatedTask);
    }

    return updatedTasks;
  }
}
