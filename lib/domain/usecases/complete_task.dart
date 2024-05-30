import 'package:flutter_application_1/domain/repository/task.dart';

class CompleteTaskUseCase {
  final TaskRepository taskRepository;

  CompleteTaskUseCase({
    required this.taskRepository,
  });

  Future<void> execute(String taskId, bool isCompleted) async {
    taskRepository.completeTask(taskId, isCompleted);
  }
}
