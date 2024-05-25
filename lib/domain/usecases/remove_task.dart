import 'package:flutter_application_1/domain/repository/task.dart';

class RemoveTaskUseCase {
  final TaskRepository taskRepository;

  RemoveTaskUseCase({
    required this.taskRepository,
  });

  Future<void> execute(String taskId) async {
    taskRepository.removeTask(taskId);
  }
}
