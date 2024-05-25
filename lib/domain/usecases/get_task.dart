import 'package:flutter_application_1/data/mappers/task.dart';
import 'package:flutter_application_1/domain/entities/task.dart';
import 'package:flutter_application_1/domain/repository/task.dart';

class GetTaskUseCase {
  final TaskRepository taskRepository;
  final TaskMapper taskMapper;

  GetTaskUseCase({
    required this.taskRepository,
    required this.taskMapper,
  });

  Future<TaskEntity> execute(String taskId) async {
    return taskMapper.mapTaskModel(await taskRepository.getTask(taskId));
  }
}
