import 'package:flutter_application_1/data/datasources/db.dart';
import 'package:flutter_application_1/data/mappers/task.dart';
import 'package:flutter_application_1/domain/entities/image.dart';
import 'package:flutter_application_1/domain/entities/task.dart';
import 'package:flutter_application_1/domain/repository/task.dart';
import 'package:flutter_application_1/domain/usecases/image.dart'; 

class GetTaskUseCase {
  final TaskRepository taskRepository;
  final TaskMapper taskMapper;
  final ImgUseCase imgUseCase; 
  GetTaskUseCase({
    required this.taskRepository,
    required this.taskMapper,
    required this.imgUseCase, 
  });

  Future<TaskEntity> getTask(String taskId) async {
    final TaskEntity task = taskMapper.mapTaskModel((await taskRepository.getTask(taskId)) as TaskModelData) as TaskEntity;
    
    final List<ImgEntity> imgUrls = await imgUseCase.getImgsOfTask(task.id);

    return task.copyWith(imgUrls: imgUrls);
  }

  void execute(String taskId) {
  }
}
