import 'package:flutter_application_1/domain/repository/task.dart';

class FavourTaskUseCase {
  final TaskRepository taskRepository;

  FavourTaskUseCase({
    required this.taskRepository,
  });

  Future<void> execute(String taskId, bool isFavourite) async {
    taskRepository.favourTask(taskId, isFavourite);
  }
}
