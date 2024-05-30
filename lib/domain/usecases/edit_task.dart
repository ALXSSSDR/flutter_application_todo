import 'package:flutter_application_1/domain/repository/task.dart';

class EditTaskUseCase {
  final TaskRepository taskRepository;

  EditTaskUseCase({
    required this.taskRepository,
  });

  Future<void> execute(String taskId, String name, String description) async {
    taskRepository.editTask(taskId, name.trim(), description);
  }
}
